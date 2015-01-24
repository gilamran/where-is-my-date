/**
 * Created by gil on 23/1/15.
 */
package {
import events.LocationChangedEvent;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;

import logic.Location;

import logic.LocationManager;

public class IntroManager {
    private var m_viewRoot          : Sprite;
    private var m_movie             : MovieClip;
    private var m_playButton        : DisplayObject;

    public function IntroManager(rootView:Sprite) {
        m_viewRoot = rootView;
        m_playButton = Utils.findChild(m_viewRoot, "playbutton_mc");
        m_movie = Utils.findChild(m_viewRoot, "introMovie") as MovieClip;
        m_movie.stop();
        m_viewRoot.addEventListener(MouseEvent.CLICK, onClick);
    }

    private function onClick(e:MouseEvent):void {
        if (m_movie.isPlaying) {
            stopMovie();
        }
        else {
            playMovie();
        }
    }

    private function playMovie():void {
        m_playButton.visible = false;
        m_movie.gotoAndPlay(0);
        m_movie.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function stopMovie():void {
        m_movie.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        m_movie.stop();
        m_viewRoot.visible = false;
        Sounds.getInstance().backgroundPlay();
    }

    private function onEnterFrame(e:Event):void {
        if (m_movie.currentFrame == m_movie.totalFrames-1) {
            stopMovie();
        }
    }

    public function dispose(): void {
        m_viewRoot.removeEventListener(MouseEvent.CLICK, onClick);
    }
}
}
