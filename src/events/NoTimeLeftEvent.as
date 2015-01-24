/**
 * Created by gil on 23/1/15.
 */
package events {
import flash.events.Event;

public class NoTimeLeftEvent extends Event {
    public static const NO_TIME_LEFT : String = "NO_TIME_LEFT";

    public function NoTimeLeftEvent(eventName:String) {
        super(eventName);
    }
}
}
