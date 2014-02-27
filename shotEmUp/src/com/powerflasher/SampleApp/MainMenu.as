package com.powerflasher.SampleApp {
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.net.URLRequest;
	import flash.events.Event;

	/**
	 * @author tiborszekely
	 */
	public class MainMenu extends Sprite {
		private var button0:MenuButton;
		private var button1:MenuButton;
		private var button2:MenuButton;
		private var introMovie:Loader;
		private var mainStage:Stage;
		
		public function MainMenu(stage:Stage) {
			mainStage = stage;
			var x:int = mainStage.stageWidth / 2;
			var y:int = mainStage.stageHeight / 2;
			
			introMovie = new Loader();
			introMovie.load(new URLRequest("SpaceShipIntro.swf"));
			introMovie.contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
			
			button0 = new MenuButton("Game 1");
			button0.addEventListener(MouseEvent.CLICK, onSelectGame0);
			
			button1 = new MenuButton("Game 2");
			button1.addEventListener(MouseEvent.CLICK, onSelectGame1);
			
			button2 = new MenuButton("Game 3");
			button2.addEventListener(MouseEvent.CLICK, onSelectGame2);
			
			
			y -= - (button0.height + button1.height + button2.height) / 2;
			
			button0.setPos(x, y);
			y += button0.height;
			button1.setPos(x, y);
			y += button1.height;
			button2.setPos(x, y);
		}
		
		private function completeListener (e:Event):void {
//			trace(stageWidth);
//			trace(stageHeight);
			trace(this.stage, introMovie);
			introMovie.width = mainStage.stageWidth;
			introMovie.height = mainStage.stageHeight;
			this.stage.addChild(introMovie);
			this.stage.addChild(button0);
			this.stage.addChild(button1);
			this.stage.addChild(button2);
		}
		
		private function onSelectGame0 (e:MouseEvent):void {
		}
		
		private function onSelectGame1 (e:MouseEvent):void {
		}
		
		private function onSelectGame2 (e:MouseEvent):void {
		}
	}
}
