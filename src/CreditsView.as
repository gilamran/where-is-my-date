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

public class CreditsView {
    private var m_viewRoot          : Sprite;

    public function CreditsView(rootView:Sprite) {
        m_viewRoot = rootView;
        m_viewRoot.addEventListener(MouseEvent.CLICK, onClick);
        hide();
    }

    private function onClick(e:MouseEvent):void {
        hide();
    }

    public function hide():void {
        if (m_viewRoot.visible) {
            m_viewRoot.visible = false;
        }
    }

    public function show():void {
        if (!m_viewRoot.visible) {
            m_viewRoot.visible = true;
        }
    }

    public function dispose(): void {
        m_viewRoot.removeEventListener(MouseEvent.CLICK, onClick);
    }
}
}
