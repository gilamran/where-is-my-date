/**
 * Created by rotem on 24/01/15.
 */
package logic {
public class Profile {
    private var _id:String;
    private var _name:String;

    public function Profile(id: String, name: String) {
        this._id = id;
        this._name = name;
    }

    public function get id():String {
        return _id;
    }
    public function get name():String {
        return _name;
    }

    public function toString():String {
        return "Profile{_id=" + String(_id) + ",_name=" + String(_name) + "}";
    }
}
}
