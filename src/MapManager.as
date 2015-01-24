/**
 * Created by gil on 23/1/15.
 */
package {
import events.LocationChangedEvent;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;

import logic.Location;

import logic.LocationManager;

public class MapManager {
    private var m_viewRoot          : Sprite;
    private var m_parent            : DisplayObjectContainer;
    private var m_pinsContainer     : Sprite;
    private var m_closeButton       : DisplayObject;
    private var m_locationManager   : LocationManager;
    private var m_savedPins         : Array = [];

    public function MapManager(rootView:Sprite) {
        m_viewRoot = rootView;
        m_parent = m_viewRoot.parent;
        m_pinsContainer = Utils.findChild(m_viewRoot, "pinsContainer") as Sprite;
        m_closeButton = Utils.findChild(m_viewRoot, "closeButton");
        m_closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClicked);
        m_locationManager = LocationManager.getInstance();
        m_locationManager.addEventListener(LocationChangedEvent.LOCATION_CHANGED, onLocationChanged);
        for (var i:int=0; i<m_pinsContainer.numChildren; i++) {
            m_savedPins.push(m_pinsContainer.getChildAt(i));
        }
        addEvents();
        updateNextLocationsPins();
        m_viewRoot.alpha = 0.99;
        m_parent.removeChild(m_viewRoot);
    }

    private function onCloseButtonClicked(e:MouseEvent):void {
        hide();
    }

    private function onLocationChanged(e:LocationChangedEvent):void {
        updateNextLocationsPins();
    }

    private function updateNextLocationsPins():void {
        hideAllLocationsPins();
        for (var i:int=0; i<m_locationManager.nextLocations.length; i++) {
            var location : Location = m_locationManager.nextLocations[i];
            showLocationPin(location.id, m_locationManager.isGoodPath(location), m_locationManager.isOnRoot()==false && i==0);
        }
    }

    private function showLocationPin(locationId:String, isGoodPath:Boolean, isParent:Boolean):void {
        for (var i:int=0; i<m_savedPins.length; i++) {
            var child : DisplayObject = m_savedPins[i];
            if (child.name == locationId) {
                var pin_regular : DisplayObject = Utils.findChild(child as DisplayObjectContainer, "pin_regular");
                var pin_parent : DisplayObject = Utils.findChild(child as DisplayObjectContainer, "pin_parent");
                pin_regular.visible = isParent==false;
                pin_parent.visible = isParent==true;
                m_pinsContainer.addChild(child);
            }

        }
    }

    private function hideAllLocationsPins():void {
        while (m_pinsContainer.numChildren>0) {
            m_pinsContainer.removeChildAt(0);
        }
    }

    public function hide():void {
        //Sounds.getInstance().playSound("travel_music");
        if (m_viewRoot.parent) {
            Sounds.getInstance().mapPause();
            Sounds.getInstance().backgroundResume();
            m_parent.removeChild(m_viewRoot);
        }
    }

    public function show():void {
        if (!m_viewRoot.parent) {
            Sounds.getInstance().backgroundPause();
            Sounds.getInstance().mapResume();
            m_parent.addChild(m_viewRoot);
        }
    }

    private function addEvents():void {
        for (var i:int=0; i<m_locationManager.locations.length; i++) {
            var location : Location = m_locationManager.locations[i];
            addClickToAsset(location.id, onLocationClicked);
        }
    }

    private function onLocationClicked(e:Event):void {
        Sounds.getInstance().playSound("icon_click");
        hide();
        m_locationManager.gotoLocation(e.currentTarget.name);
    }

    private function addClickToAsset(assetName:String, callback:Function):void {
        var dispObj : DisplayObject = Utils.findChild(m_viewRoot, assetName);
        dispObj.addEventListener(MouseEvent.CLICK, callback);
    }

    public function dispose(): void {
        m_closeButton.removeEventListener(MouseEvent.CLICK, onCloseButtonClicked);
        m_locationManager.removeEventListener(LocationChangedEvent.LOCATION_CHANGED, onLocationChanged);
    }
}
}
