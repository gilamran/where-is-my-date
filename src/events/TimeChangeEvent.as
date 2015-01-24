/**
 * Created by gil on 23/1/15.
 */
package events {
import flash.events.Event;

public class TimeChangeEvent extends Event {
    public static const TIME_CHANGED : String = "TIME_CHANGED";

    public var timeLeft : Number;

    public function TimeChangeEvent(eventName:String, timeLeft : Number) {
        this.timeLeft = timeLeft;
        super(eventName);
    }
}
}
