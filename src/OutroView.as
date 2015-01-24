/**
 * Created by gil on 24/1/15.
 */
package {
import asset.AssetsManager;

import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class OutroView extends Sprite {
    private var m_movie          : MovieClip;
    private var m_darkBG         : Shape;

    public function OutroView(outroId:int) {
        m_darkBG = new Shape();
        m_darkBG.graphics.beginFill(0x000000, 0.8);
        m_darkBG.graphics.drawRect(0, 0, 100, 100);
        m_darkBG.graphics.endFill();

        //Assets.getClue(clue, i);
        m_movie = AssetsManager.getInstance().getAsset('outro' + outroId.toString()) as MovieClip;
        m_movie.width = 80;
        m_movie.height = 80;
        m_movie.x = 10;
        m_movie.y = 10;

        addChild(m_darkBG);
        addChild(m_movie);
        addEventListener(MouseEvent.CLICK, onContainerClick);
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Event):void {
        width = stage.stageWidth;
        height = stage.stageHeight;
    }

    private function onEnterFrame(e:Event):void {
        if (m_movie.currentFrame == m_movie.totalFrames-1) {
            stopMovie();
        }
    }

    private function onContainerClick(e:MouseEvent):void {
        stopMovie();
    }

    public function playMovie():void {
        m_movie.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        m_movie.gotoAndPlay(0);
    }

    public function stopMovie():void {
        parent.removeChild(this);
        m_movie.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        m_movie.stop();
    }

    public function dispose(): void {
        removeEventListener(MouseEvent.CLICK, onContainerClick);
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }
}
}
