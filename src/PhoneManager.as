/**
 * Created by gil on 23/1/15.
 */
package {
import events.PhoneButtonClickedEvent;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;

public class PhoneManager extends EventDispatcher {
    private var m_viewRoot   : Sprite;

    public function PhoneManager(viewRoot:Sprite) {
        super();
        m_viewRoot = viewRoot;
        addEvents();
    }

    private function addEvents():void {
        addClickToAsset("infoIcon_mc", onButtonClicked);
        addClickToAsset("mapsIcon_mc", onButtonClicked);
    }

    private function onButtonClicked(e:Event):void {
        dispatchEvent(new PhoneButtonClickedEvent(PhoneButtonClickedEvent.PHONE_BUTTON_CLICKED, e.target.name));
    }

    private function addClickToAsset(assetName:String, callback:Function):void {
        var dispObj : DisplayObject = Utils.findChild(m_viewRoot, assetName);
        dispObj.addEventListener(MouseEvent.CLICK, callback);
    }

    public function dispose(): void {
    }
}
}
