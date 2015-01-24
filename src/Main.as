package {

import asset.AssetsManager;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.media.Sound;
import flash.text.TextField;

public class Main extends Sprite {

    private var m_mainScene  : MainScene;

    public function Main() {
        stage.color = 0xdddddd;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        var assets: AssetsManager = AssetsManager.getInstance();
        assets.addEventListener(Event.COMPLETE, onAssetLoaded);
        if (assets.assetsReady) onAssetLoaded(null);
    }

    private function onAssetLoaded(event:Event):void {
        trace("asset loaded");

//        var sound : Sound = AssetsManager.getInstance().getAsset("backgroundMusic") as Sound;
//        sound.play();

        m_mainScene = new MainScene();
        m_mainScene.width = stage.stageWidth;
        m_mainScene.height = stage.stageHeight;
        addChild(m_mainScene);
        stage.addEventListener(flash.events.Event.RESIZE, onStageResized);
    }

    private function onStageResized(e:Event):void {
        m_mainScene.width = stage.stageWidth;
        m_mainScene.height = stage.stageHeight;
    }

    public function dispose(): void {
        AssetsManager.getInstance().removeEventListener(Event.COMPLETE, onAssetLoaded);
    }
}
}
