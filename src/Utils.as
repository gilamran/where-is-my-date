/**
 * Created by gil on 23/1/15.
 */
package {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

public class Utils {
    public function Utils() {
    }

    public static function findChild(parent:DisplayObjectContainer, childName:String):DisplayObject {
        for (var i:int=0; i<parent.numChildren; i++) {
            var child : DisplayObject = parent.getChildAt(i);
            var asContainer : DisplayObjectContainer = child as DisplayObjectContainer;
            if (child.name === childName) {
                return child;
            }
            else {
                if (asContainer) {
                    var innerChild = findChild(asContainer, childName);
                    if (innerChild)
                        return innerChild;
                }
            }
        }
        return null;
    }
}
}
