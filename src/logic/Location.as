/**
 * Created by rotem on 23/01/15.
 */
package logic {
public class Location {
    private var _id: String;
    private var _name: String;
    private var _text: String;
    private var _clues: Vector.<String>;

    public function Location(id: String, name: String, text: String, clues: Vector.<String>) {
        _id = id;
        _name = name;
        _text = text;
        _clues = new Vector.<String>();
        for (var i:int=0; i<clues.length; i++) {
            _clues.push(id + "_clue_" + clues[i]);
        }
    }

    public function get id():String {
        return _id;
    }

    public function get name():String {
        return _name;
    }

    public function get text():String {
        return _text;
    }

    public function get clues():Vector.<String> {
        return _clues;
    }


    public function toString():String {
        return "Location{" + String(_id) + "}";//,_name=" + String(_name) + "}";
    }
}
}
