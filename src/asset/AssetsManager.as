/**
 * Created by gil on 23/1/15.
 */
package asset {

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.media.Sound;
import flash.utils.ByteArray;

public class AssetsManager extends EventDispatcher {
    private static var m_instance : AssetsManager;

    public static function getInstance():AssetsManager {
        if (!m_instance) {
            m_instance = new AssetsManager();
        }
        return m_instance;
    }


//    [Embed(source="../fla/where-is-my-date.swf", symbol="MainScene")]
    [Embed(source="../../fla/where-is-my-date.swf", mimeType="application/octet-stream")]
    public static var MainScene:Class;
    private var assetsLoader: IAssetsLoader;
    private var mainSceneAssetsFactory: IAssetsFactory;

    public function AssetsManager() {
        super();
        var assetsByteArrays : Vector.<ByteArray> = new Vector.<ByteArray>;
        assetsByteArrays.push(new MainScene());
//        assetsByteArrays.push(new SoundsAssetsClass());
        assetsLoader = new AssetsLoaderFromByteArray(assetsByteArrays);
        mainSceneAssetsFactory = new AssetsFactoryFromAssetsLoader(assetsLoader);

        assetsLoader.addEventListener(Event.COMPLETE, onAssetLoaded);
        assetsLoader.initializeAllAssets();
    }

    private function onAssetLoaded(event:Event):void {
        assetsLoader.removeEventListener(Event.COMPLETE, onAssetLoaded);
        dispatchEvent(new Event(Event.COMPLETE));
    }

    public function get assetsReady(): Boolean {
        return assetsLoader.assetsReady;
    }

    public function getAsset(symbol: String): Object {
        return mainSceneAssetsFactory.createAsset(symbol);
    }

//    public static function getBackgroundSound():Sound {
//        return new BackgroundSound()
//    }

//    public static function getMainSceneAsset():Sprite {
//        return new MainScene();
//    }
}
}
