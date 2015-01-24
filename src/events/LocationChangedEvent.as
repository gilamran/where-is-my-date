/**
 * Created by gil on 23/1/15.
 */
package events {
import flash.events.Event;

import logic.Location;

public class LocationChangedEvent extends Event {
    public static const LOCATION_CHANGED : String = "LOCATION_CHANGED";

    public var location : Location;

    public function LocationChangedEvent(eventName:String, location:Location) {
        this.location = location;
        super(eventName);
    }
}
}
