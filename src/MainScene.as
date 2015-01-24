/**
 * Created by gil on 23/1/15.
 */
package {
import asset.AssetsManager;

import events.FinalLocationEvent;
import events.LocationChangedEvent;
import events.NoTimeLeftEvent;
import events.PhoneButtonClickedEvent;
import events.TimeChangeEvent;

import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;

import logic.LocationManager;
import logic.LocationsData;

public class MainScene extends Sprite {

    private var m_phoneManager          : PhoneManager;
    private var m_creditsView           : CreditsView;
    private var m_timebarManager        : TimeBarManager;
    private var m_mapManager            : MapManager;
    private var m_locationViewManager   : LocationViewManager;
    private var m_locationManager       : LocationManager;
    private var m_introManager          : IntroManager;
    private var m_sceneAssets           : Sprite;

    public function MainScene() {
        graphics.beginFill(0xffffff, 0);
        graphics.drawCircle(10 ,10, 1);
        graphics.endFill();

        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(e:Event):void {
        scaleX = scaleY = 1;
        m_sceneAssets =  AssetsManager.getInstance().getAsset("MainScene") as Sprite;
        m_sceneAssets.width = stage.stageWidth;
        m_sceneAssets.height = stage.stageHeight;
        addChild(m_sceneAssets);

        m_creditsView = new CreditsView(Utils.findChild(m_sceneAssets, "credits_mc") as Sprite);
        m_introManager = new IntroManager(Utils.findChild(m_sceneAssets, "intro_mc") as Sprite);

        m_timebarManager = new TimeBarManager(Utils.findChild(m_sceneAssets, "timebar_mc") as Sprite);
        m_timebarManager.setTime(1);

        m_phoneManager = new PhoneManager(Utils.findChild(m_sceneAssets, "phoneAssets") as Sprite);
        m_phoneManager.addEventListener(PhoneButtonClickedEvent.PHONE_BUTTON_CLICKED, onPhoneButtonClicked);

        m_mapManager = new MapManager(Utils.findChild(m_sceneAssets, "mapContainer") as Sprite);

        m_locationViewManager = new LocationViewManager(Utils.findChild(m_sceneAssets, "locationsView") as Sprite);

        m_locationManager = LocationManager.getInstance();
        m_locationManager.addEventListener(LocationChangedEvent.LOCATION_CHANGED, onLocationChanged);
        m_locationManager.addEventListener(FinalLocationEvent.FINAL_LOCATION, onFinalLocation);
        m_locationManager.addEventListener(TimeChangeEvent.TIME_CHANGED, onTimeChange);
        m_locationManager.addEventListener(NoTimeLeftEvent.NO_TIME_LEFT, onNoTimeLeft);

        m_locationManager.fireCurrentLocationChanged();
    }

    private function onNoTimeLeft(event:NoTimeLeftEvent):void {
//        Sounds.getInstance().backgroundPause();
        addChild(new OutroView(0));
    }

    private function onTimeChange(event:TimeChangeEvent):void {
        m_timebarManager.setTime(event.timeLeft);
    }

    private function onLocationChanged(e:LocationChangedEvent):void {
        m_locationViewManager.showLocationView(e.location);
    }

    private function onFinalLocation(e:FinalLocationEvent):void {
//        Sounds.getInstance().backgroundPause();
        var outroId: int = Math.random() * 7 + 1;
        addChild(new OutroView(outroId));
    }

    private function onPhoneButtonClicked(e:PhoneButtonClickedEvent):void {
        //trace("Phone button clicked", e.buttonName);
        Sounds.getInstance().playSound("icon_click");
        switch (e.buttonName) {
            case "mapsIcon_mc" : m_mapManager.show(); break;
            case "infoIcon_mc" : m_creditsView.show(); break;
        }
    }

    public function dispose(): void {
        m_phoneManager.removeEventListener(PhoneButtonClickedEvent.PHONE_BUTTON_CLICKED, onPhoneButtonClicked);
        m_locationManager.removeEventListener(LocationChangedEvent.LOCATION_CHANGED, onLocationChanged);
        m_locationManager.removeEventListener(FinalLocationEvent.FINAL_LOCATION, onFinalLocation);
        m_locationManager.removeEventListener(TimeChangeEvent.TIME_CHANGED, onTimeChange);
        m_locationManager.removeEventListener(NoTimeLeftEvent.NO_TIME_LEFT, onNoTimeLeft);

        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }
}
}
