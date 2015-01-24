/**
 * Created by gil on 23/1/15.
 */
package events {
import flash.events.Event;

public class FinalLocationEvent extends Event {
    public static const FINAL_LOCATION : String = "FINAL_LOCATION";

    public function FinalLocationEvent(eventName:String) {
        super(eventName);
    }
}
}
