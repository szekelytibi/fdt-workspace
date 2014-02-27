package com.powerflasher.SampleApp {
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.display.AVM1Movie;
	import flash.net.URLRequest;
	import flash.events.Event;
//	import flash.desktop.NativeApplication;
	import flash.system.fscommand;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	

	/**
	 * @author tiborszekely
	 */
	public class MainMenu extends Sprite {
		private var button0:MenuButton;
		private var button1:MenuButton;
		private var button2:MenuButton;
		private var buttonExit:MenuButton;
		private var introMovie:Loader;
		private var mainStage:Stage;
		
		public function MainMenu(stage:Stage) {
			mainStage = stage;
			var x:int = mainStage.stageWidth / 2;
			var y:int = mainStage.stageHeight / 2;
			
			introMovie = new Loader();
			introMovie.contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
			introMovie.load(new URLRequest("SpaceShipIntro.swf"));
			
			button0 = new MenuButton("GAME1");
			button0.addEventListener(MouseEvent.CLICK, onSelectGame0);
			
			button1 = new MenuButton("GAME2");
			button1.addEventListener(MouseEvent.CLICK, onSelectGame1);
			
			button2 = new MenuButton("GAME3");
			button2.addEventListener(MouseEvent.CLICK, onSelectGame2);
			
			buttonExit = new MenuButton("EXIT");
			buttonExit.addEventListener(MouseEvent.CLICK, onSelectExit);
			
			
			
			y -= (button0.height + button1.height + button2.height + buttonExit.height) / 2;
			
			button0.setPos(x, y);
			y += button0.height;
			button1.setPos(x, y);
			y += button1.height;
			button2.setPos(x, y);
			y += button2.height;
			buttonExit.setPos(x, y);
		}
		
		private function completeListener (e:Event):void {
			introMovie.width = mainStage.stageWidth;
			introMovie.height = mainStage.stageHeight;
			
			
			this.stage.addChild(introMovie);
			this.stage.addChild(button0);
			this.stage.addChild(button1);
			this.stage.addChild(button2);
			this.stage.addChild(buttonExit);
			
			SoundMixer.soundTransform = new SoundTransform(0.1, 0);;			
		}
		
		private function onSelectGame0 (e:MouseEvent):void {
			closeMenu();
		}
		
		private function onSelectGame1 (e:MouseEvent):void {
			closeMenu();
		}
		
		private function onSelectGame2 (e:MouseEvent):void {
			closeMenu();
		}
		
		private function onSelectExit (e:MouseEvent):void {
			closeMenu();
			fscommand("quit");
		}
		
		private function closeMenu():void{
			SoundMixer.soundTransform = new SoundTransform(0, 0);
			trace(SoundMixer.audioPlaybackMode);
			trace(introMovie.contentLoaderInfo.contentType);
			
			this.stage.removeChild(introMovie);
			this.stage.removeChild(button0);
			this.stage.removeChild(button1);
			this.stage.removeChild(button2);
			this.stage.removeChild(buttonExit);
		}
		
	}
}
