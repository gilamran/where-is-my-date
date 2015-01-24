/**
 * Created by rotem on 23/01/15.
 */
package logic {
public class LocationsData {
    public function LocationsData() {

    }

    public static function getLocations():Vector.<Location> {
        var locations:Vector.<Location> = new Vector.<Location>();

        var clues = new Vector.<String>();
        clues.push('1');
        clues.push('2');
        clues.push('3');
        locations.push(new Location("tel_aviv_port", "Tel Aviv Port", "This is Tel Aviv Port Text", clues));
        locations.push(new Location("azrieli", "Azrieli", "This is Azrieli Text", clues));
        locations.push(new Location("city_house", "City House", "This is City House Text", clues));
        locations.push(new Location("jaffa_clock", "Jaffa Clock", "This is Jaffa Clock Text", clues));
        locations.push(new Location("habima_square", "Habima Square", "This is Habima Square Text", clues));
        locations.push(new Location("rabin_square", "Rabin Square", "This is Rabin Square Text", clues));
        locations.push(new Location("dizengoff_center", "Dizengoff Center", "This is Dizengoff Center Text", clues));
        locations.push(new Location("nave_tzedek", "Nave Tzedek", "This is Nave Tzedek Text", clues));
        locations.push(new Location("hatachana", "Hatachana", "This is Hatachana Text", clues));
        locations.push(new Location("cinematheque", "Cinematheque", "This is Cinematheque Text", clues));
        locations.push(new Location("rotchild", "Rotchild ", "This is Rotchild Text", clues));
        locations.push(new Location("sarona", "Sarona", "This is Sarona Text", clues));

        return locations;

    }

    public static function getNoClue():Vector.<String> {
        var clues = new Vector.<String>();
        clues.push('no_clue_1');
        clues.push('no_clue_2');
        clues.push('no_clue_3');
        return clues;
    }

}
}
