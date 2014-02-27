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
	[SWF( frameRate="30", backgroundColor="0x000000", width="800", height="600" )]
	public class Main extends Sprite {
		private var titleImage:Loader;
		private var mainMenu:MainMenu;
		private const fadeAmount:int = 25;
		private const titleAmount:int = 100;
		private var titleTimer:Timer = new Timer(10, titleAmount);
		private var fadeCount:int = 0;
		public function Main() {
			titleImage = new Loader();
			titleImage.load(new URLRequest("Title.gif"));
			titleImage.contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
		}
		
		private function completeListener (e:Event):void {
        	dispatchEvent(new Event(Event.COMPLETE));
			titleImage.width = this.stage.stageWidth;
			titleImage.height = this.stage.stageHeight;
			titleImage.alpha = 0;
			this.stage.addChild(titleImage);
			titleTimer.start();
			titleTimer.addEventListener(TimerEvent.TIMER, timerHandler);
            titleTimer.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
		}
		
		private function timerHandler(e:TimerEvent):void{
			fadeCount++;
			if(fadeCount <= fadeAmount){
				titleImage.alpha = fadeCount / fadeAmount;
			}
			else if((titleAmount-fadeAmount) <= fadeCount ){
				titleImage.alpha = (titleAmount-fadeCount) / fadeAmount;
			}
			else
				titleImage.alpha = 1;
				
//			trace(fadeCount, titleImage.alpha);
				
				
			e.updateAfterEvent();
        }

        private function completeHandler(e:TimerEvent):void {
			this.stage.removeChild(titleImage);
			mainMenu = new MainMenu(this.stage);
			this.stage.addChild(mainMenu);
        }
		
	}
	
}
