/**
 * Created by gil on 23/1/15.
 */
package {
import events.LocationChangedEvent;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;

import logic.Location;

import logic.LocationManager;

public class TimeBarManager {
    private var m_viewRoot          : Sprite;
    private var m_bar               : DisplayObject;

    public function TimeBarManager(rootView:Sprite) {
        m_viewRoot = rootView;
        m_bar = Utils.findChild(m_viewRoot, "bar_gfx");
    }

    public function setTime(value:Number):void {
        m_bar.scaleX = value;
    }
}
}
