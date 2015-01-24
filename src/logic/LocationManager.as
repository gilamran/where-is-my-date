/**
 * Created by rotem on 23/01/15.
 */
package logic {
import events.FinalLocationEvent;
import events.LocationChangedEvent;
import events.NoTimeLeftEvent;
import events.TimeChangeEvent;

import flash.events.EventDispatcher;

public class LocationManager extends EventDispatcher {
    private static var m_instance : LocationManager;

    public static function getInstance():LocationManager {
        if (!m_instance) {
            m_instance = new LocationManager(LocationsData.getLocations(), LocationsData.getNoClue());
        }
        return m_instance;
    }

    public static function resetInstance():LocationManager {
        m_instance = null;
        return getInstance();
    }


    private const numberOfLocations: int = 4;
    private const totalTime: int = 4 * 60;

    private var _locations:Vector.<Location>;
    private var _noClues:Vector.<String>;
    private var _currentLocation: PathNode;
    private var _root: PathNode;
    private var _timeLeft: int = totalTime;


    public function getLocationById(locationId:String):Location {
        for (var i:int=0; i<_locations.length; i++) {
            if (_locations[i].id == locationId) {
                return _locations[i];
            }
        }

        return null;
    }

    public function LocationManager(locations: Vector.<Location>, noClues: Vector.<String>) {
        super();
        _locations = locations;
        _noClues = noClues;
        _root = generateTree(null, true, 4);
        _currentLocation = _root;
        _currentLocation.firstClueView = false;
    }

    private function generateTree(root: PathNode, isReal: Boolean, depth: int): PathNode {
        var myLocation: Location = selectRandomLocation(root);
        var childs: Vector.<PathNode> = new Vector.<PathNode>();
        var self: PathNode = new PathNode(myLocation, isReal, childs);
        if (root != null) {
            childs.push(root);
        }
        if (depth > 0) {
            var needToGen:int = numberOfLocations - childs.length;
            var realIdx:int = isReal ? Math.random() * needToGen : - 1;
            for (var i:int = 0; i < needToGen; i++) {
                childs.push(generateTree(self, (realIdx == i), depth - 1));
            }
        }
        return self;
    }

    private function selectRandomLocation(parent: PathNode): Location {
        var disallowLocations: Vector.<Location> = new Vector.<Location>();
        if (parent != null) {
            disallowLocations.push(parent.currentLocation);
            var brothers: Vector.<PathNode> = parent.nextLocations;
            for (var i:int = 0; i < brothers.length; i++) {
                disallowLocations.push(brothers[i].currentLocation);
            }
            if (parent.isReal) {
                var realPathParent:PathNode = parent;
                while (realPathParent.nextLocations.length > 0 &&
                realPathParent.nextLocations[0].nextLocations > 0 &&
                realPathParent != realPathParent.nextLocations[0].nextLocations[0]) {
                    realPathParent = realPathParent.nextLocations[0];
                    disallowLocations.push(realPathParent.currentLocation);
                }
            }
        }
        var locationIdx: int;
        do {
            locationIdx = Math.random() * _locations.length;
        } while (disallowLocations.indexOf(_locations[locationIdx]) >= 0);
        return _locations[locationIdx];
    }

    public function get root():PathNode {
        return _root;
    }
    public function get currentLocation():Location {
        return _currentLocation.currentLocation;
    }

    public function fireCurrentLocationChanged():void {
        dispatchEvent(new LocationChangedEvent(LocationChangedEvent.LOCATION_CHANGED, _currentLocation.currentLocation));
    }

    public function get nextLocations(): Vector.<Location> {
        var pn: Vector.<PathNode> = _currentLocation.nextLocations;
        var nl: Vector.<Location> = new Vector.<Location>();
        for (var i: int = 0; i < pn.length; i++) {
            nl.push(pn[i].currentLocation);
        }
        return nl;
    }

    public function get nextClues(): Vector.<String> {
        var pn: Vector.<PathNode> = _currentLocation.nextLocations;
        var firstIdx: int = _currentLocation == _root ? 0 : 1;
        for (var i: int = firstIdx; i < pn.length; i++) {
            if (pn[i].isReal) {
                return pn[i].currentLocation.clues;
            }
        }
        return shuffle(_noClues);
    }

    public function useClue(clueId: String): void {
        _currentLocation.firstClueView = false;
        timeLeft -= 5;
    }


    public function gotoLocation(locationId: String):void {
        var l :Location = getLocationById(locationId);
        var nl: Vector.<PathNode> = _currentLocation.nextLocations;
        for (var i: int = 0; i < nl.length; i++) {
            if (nl[i].currentLocation == l) {
                _currentLocation = nl[i];
                timeLeft -= 20;
                fireCurrentLocationChanged();
            }
        }
        if (_currentLocation.nextLocations.length == 1 && _currentLocation.isReal) {
            dispatchEvent(new FinalLocationEvent(FinalLocationEvent.FINAL_LOCATION));
        }
    }
    public function isOnRoot():Boolean {
        return _currentLocation == _root;
    }

    public function isGoodPath(location: Location):Boolean {
        var nl: Vector.<PathNode> = _currentLocation.nextLocations;
        for (var i: int = 0; i < nl.length; i++) {
            if (nl[i].currentLocation == location) {
                return nl[i].isReal;
            }
        }
        return false;
    }
    public function isCurrentLocationGood():Boolean {
        return _currentLocation.isReal;
    }
    public function isFirstClueView():Boolean {
        return _currentLocation.firstClueView;
    }

    public function get locations():Vector.<Location> {
        return _locations;
    }


    public function toJson(node: PathNode): Object {
        var json = {}
        json.id = node.currentLocation.id;
        json.real = node.isReal;
        json.children = [];
        for(var i: int = 1; i<node.nextLocations.length; i++) {
            json.children.push(toJson(node.nextLocations[i]));
        }
        return json;
    }

    public function get timeLeft():int {
        return _timeLeft;
    }

    public function set timeLeft(value:int):void {
        _timeLeft = value;
        trace("time="+value);
        dispatchEvent(new TimeChangeEvent(TimeChangeEvent.TIME_CHANGED, value/totalTime));
        if (_timeLeft <=0 ) {
            dispatchEvent(new NoTimeLeftEvent(NoTimeLeftEvent.NO_TIME_LEFT));
        }
    }


    private function shuffle(v: Vector.<String>): Vector.<String>
    {
        function swap(i1: int, i2: int): void
        {
            var tmp: * = v[i1]
            v[i1] = v[i2]
            v[i2] = tmp
        }

        for (var n:int = v.length; n > 2; n--)
        {
            var k: int = Math.floor(Math.random() * n);
            swap(n - 1, k)
        }

        return v;
    }
}
}

import logic.Location;

class PathNode {
    private var _currentLocation:Location;
    private var _nextLocations:Vector.<PathNode>;
    private var _isReal: Boolean = false;
    public var firstClueView: Boolean;

    public function PathNode(currentLocation: Location, isReal: Boolean, nextLocations: Vector.<PathNode>) {
        _currentLocation = currentLocation;
        _isReal = isReal;
        _nextLocations = nextLocations;
        firstClueView = true;
    }

    public function get currentLocation():Location {
        return _currentLocation;
    }

    public function get nextLocations():Vector.<PathNode> {
        return _nextLocations;
    }

    public function get isReal():Boolean {
        return _isReal;
    }
}
