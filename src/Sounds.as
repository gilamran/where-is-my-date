/**
 * Created by rotem on 24/01/15.
 */
package {
import asset.AssetsManager;

import flash.media.Sound;

import flash.media.SoundChannel;
import flash.media.SoundTransform;

public class Sounds {
    private static var m_instance : Sounds;

    public static function getInstance():Sounds {
        if (!m_instance) {
            m_instance = new Sounds();
        }
        return m_instance;
    }


    private static var backgroundMusic : Sound = AssetsManager.getInstance().getAsset("localtion_music") as Sound;
    private var m_backgroundSoundChannel 	: SoundChannel;
    private var backgroundPausePosition:int = -1;
    private var isBackgroundMusicPlay:Boolean = false;
    private var backgroundSoundTransform:SoundTransform = new SoundTransform(1);

    private static var mapMusic : Sound = AssetsManager.getInstance().getAsset("travel_music") as Sound;
    private var m_mapSoundChannel 	: SoundChannel;
    private var mapPausePosition:int = -1;
    private var isMapMusicPlay:Boolean = false;
    private var mapSoundTransform:SoundTransform = new SoundTransform(0.6);

    public function Sounds() {
    }

    public function backgroundPlay(): void {
        if (! isBackgroundMusicPlay) {
            m_backgroundSoundChannel = backgroundMusic.play(0, int.MAX_VALUE, backgroundSoundTransform);
            isBackgroundMusicPlay = true;
        }
    }
    public function backgroundPause(): void {
        if (isBackgroundMusicPlay) {
            backgroundPausePosition = m_backgroundSoundChannel.position;
            m_backgroundSoundChannel.stop();
            isBackgroundMusicPlay = false;
        }
    }
    public function backgroundResume(): void {
        if (! isBackgroundMusicPlay) {
            m_backgroundSoundChannel = backgroundMusic.play(backgroundPausePosition, int.MAX_VALUE, backgroundSoundTransform);
            isBackgroundMusicPlay = true;
        }
    }
    public function backgroundStop(): void {
        if (isBackgroundMusicPlay) {
            m_backgroundSoundChannel.stop();
            isBackgroundMusicPlay = false;
        }
    }

    public function mapPlay(): void {
        if (! isMapMusicPlay) {
            m_mapSoundChannel = mapMusic.play(0, int.MAX_VALUE, mapSoundTransform);
            isMapMusicPlay = true;
        }
    }
    public function mapPause(): void {
        if (isMapMusicPlay) {
            mapPausePosition = m_mapSoundChannel.position;
            m_mapSoundChannel.stop();
            isMapMusicPlay = false;
        }
    }
    public function mapResume(): void {
        if (! isMapMusicPlay) {
            m_mapSoundChannel = mapMusic.play(mapPausePosition, int.MAX_VALUE, mapSoundTransform);
            isMapMusicPlay = true;
        }
    }
    public function mapStop(): void {
        if (isMapMusicPlay) {
            m_mapSoundChannel.stop();
            isMapMusicPlay = false;
        }
    }

    public function playSound(symbol: String): SoundChannel {
        var sound: Sound = AssetsManager.getInstance().getAsset(symbol) as Sound;
        return sound.play();
    }

    public function dispose(): void {

    }
}
}
