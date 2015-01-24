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

import logic.LocationManager;

public class ClueView extends Sprite {
    private var m_movieContainer : Sprite;
    private var m_button         : Shape;
    private var m_movie          : MovieClip;
    private var m_darkBG         : Shape;
    private var clueId:String;

    public function ClueView(clueId:String) {
        trace("Showing clue", clueId);
        this.clueId = clueId;
        m_button = new Shape();
        m_button.graphics.beginFill(0xffff00, 0.8);
        m_button.graphics.drawRect(0, 0, 100, 100);
        m_button.graphics.endFill();
        addChild(m_button);
        addEventListener(MouseEvent.CLICK, onButtonClicked);

        m_darkBG = new Shape();
        m_darkBG.graphics.beginFill(0x000000, 0.8);
        m_darkBG.graphics.drawRect(0, 0, 100, 100);
        m_darkBG.graphics.endFill();

        //Assets.getClue(clue, i);
        m_movie = AssetsManager.getInstance().getAsset(clueId) as MovieClip;
        m_movie.stop();
        m_movie.width = 80;
        m_movie.height = 80;
        m_movie.x = 10;
        m_movie.y = 10;

        m_movieContainer = new Sprite();
        m_movieContainer.addChild(m_darkBG);
        m_movieContainer.addChild(m_movie);
        m_movieContainer.addEventListener(MouseEvent.CLICK, onContainerClick);
    }

    private function onButtonClicked(e:MouseEvent):void {
        playMovie();
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
        if (LocationManager.getInstance().timeLeft > 0) {
            if (LocationManager.getInstance().isFirstClueView()) {
                if (LocationManager.getInstance().isCurrentLocationGood()) {
                    Sounds.getInstance().playSound("right_location");
                } else {
                    Sounds.getInstance().playSound("wrong_location");
                }
            } else {
                Sounds.getInstance().playSound("person_click");
            }
            m_movieContainer.width = stage.stageWidth;
            m_movieContainer.height = stage.stageHeight;
            stage.addChild(m_movieContainer);

            LocationManager.getInstance().useClue(clueId);
            Sounds.getInstance().backgroundPause();
            m_movie.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            m_movie.gotoAndPlay(0);
        }
    }

    public function stopMovie():void {
        stage.removeChild(m_movieContainer);
        m_movie.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        m_movie.stop();
        Sounds.getInstance().backgroundResume();
    }

    public function dispose(): void {
        m_movieContainer.removeEventListener(MouseEvent.CLICK, onContainerClick);
    }
}
}
