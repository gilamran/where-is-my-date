/**
 * Created by gil on 23/1/15.
 */
package events {
import flash.events.Event;

public class PhoneButtonClickedEvent extends Event {
    public static const PHONE_BUTTON_CLICKED : String = "PHONE_BUTTON_CLICKED";

    public var buttonName : String;

    public function PhoneButtonClickedEvent(eventName:String, buttonName:String) {
        this.buttonName = buttonName;
        super(eventName);
    }
}
}
