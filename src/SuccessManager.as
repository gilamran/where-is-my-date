/**
 * Created by gil on 23/1/15.
 */
package {
import events.LocationChangedEvent;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;

import logic.Location;

import logic.LocationManager;

public class SuccessManager {
    private var m_viewRoot:Sprite;

    public function SuccessManager(rootView:Sprite) {
        m_viewRoot = rootView;
    }

    public function hide():void {
        m_viewRoot.visible = false;
    }

    public function show():void {
        m_viewRoot.visible = true;
    }

}
}
