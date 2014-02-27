package com.powerflasher.SampleApp {
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.events.TimerEvent;


	/**
	 * @author tiborszekely
	 */
	public class Main extends Sprite {
		private var titleImage:Loader;
		private var mainMenu:MainMenu;
		private var titleTimer:Timer = new Timer(20, 100);
		public function Main() {
			titleImage = new Loader();
			titleImage.load(new URLRequest("Title.gif"));
			titleImage.contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
		}
		
		private function completeListener (e:Event):void {
        	dispatchEvent(new Event(Event.COMPLETE));
			titleImage.width = this.stage.stageWidth;
			titleImage.height = this.stage.stageHeight;
			this.stage.addChild(titleImage);
			titleTimer.start();
			titleTimer.addEventListener(TimerEvent.TIMER, timerHandler);
            titleTimer.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
		}
		
		private function timerHandler(e:TimerEvent):void{
			//trace(e);
			e.updateAfterEvent();
        }

        private function completeHandler(e:TimerEvent):void {
			this.stage.removeChild(titleImage);
			trace(e);
			mainMenu = new MainMenu(this.stage);
			this.stage.addChild(mainMenu);
        }
		
	}
	
}
