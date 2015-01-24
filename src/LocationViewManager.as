/**
 * Created by gil on 23/1/15.
 */
package {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.LocalConnection;

import logic.Location;

import logic.LocationManager;

public class LocationViewManager {
    private var m_viewRoot:Sprite;
    private var m_locationManager:LocationManager;
    private var m_currentClues:Array;

    public function LocationViewManager(viewRoot:Sprite) {
        m_currentClues = [];
        m_viewRoot = viewRoot;
        m_locationManager = LocationManager.getInstance();
    }

    public function showLocationView(location:Location):void {
        trace("Moved to location:", location.id);

        removePreviousClues();
        for (var i:int = 0; i < m_viewRoot.numChildren; i++) {
            var locationView:DisplayObjectContainer = m_viewRoot.getChildAt(i) as DisplayObjectContainer;
            if (locationView.name == location.id) {
                locationView.visible = true;
                showLocationClues(location, locationView);
            }
            else {
                locationView.visible = false;
            }
        }
    }

    private function showLocationClues(location:Location, parent:DisplayObjectContainer):void {
        var clues = m_locationManager.nextClues;
        for (var i:int = 0; i < clues.length; i++) {
            var clue = clues[i];
            var clueView:DisplayObject = new ClueView(clue);
            addClue(clueView, parent);
        }
    }

    private function addClue(display:DisplayObject, parent:DisplayObjectContainer):void {
        m_currentClues.push(display);
        display.x = m_currentClues.length * 120;
        display.y = 50;
        parent.addChild(display);
    }

    private function removePreviousClues():void {
        while (m_currentClues.length > 0) {
            var clue:DisplayObject = m_currentClues.pop();
            clue.parent.removeChild(clue);
        }
    }
}
}
