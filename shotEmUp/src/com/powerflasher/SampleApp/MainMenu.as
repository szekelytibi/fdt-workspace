package com.powerflasher.SampleApp {
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.display.AVM1Movie;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.desktop.NativeApplication;
	import flash.system.fscommand;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.display.Bitmap;
	
	

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
		private var game:Game;
		private static var instance:MainMenu;
		
		[Embed (source="assets/Logo.gif" )]
		public static const logo:Class;
		
		[Embed (source="assets/Alien1.gif" )]
		public static const alien1icon:Class;
		[Embed (source="assets/Alien2.gif" )]
		public static const alien2icon:Class;
		[Embed (source="assets/Alien3.gif" )]
		public static const alien3icon:Class;
		[Embed (source="assets/ExitIcon.png" )]
		public static const exitIcon:Class;
		
		
		
		public static function open():void{
			instance.show();
		}
		
		public function MainMenu(stage:Stage){
			instance = this;
			mainStage = stage;
			show();
		}
		
		public function show():void{
			var x:int = mainStage.stageWidth / 2;
			var y:int = mainStage.stageHeight / 2;
			
			introMovie = new Loader();
			introMovie.contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
			introMovie.load(new URLRequest("SpaceShipIntro.swf"));
			
			button0 = new MenuButton("GAME1", alien1icon);
			button0.addEventListener(MouseEvent.CLICK, onSelectGame0);
			
			button1 = new MenuButton("GAME2", alien2icon);
			button1.addEventListener(MouseEvent.CLICK, onSelectGame1);
			
			button2 = new MenuButton("GAME3", alien3icon);
			button2.addEventListener(MouseEvent.CLICK, onSelectGame2);
			
			buttonExit = new MenuButton("EXIT", exitIcon);
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
			
			SoundMixer.soundTransform = new SoundTransform(0.005, 0);;			
		}
		
		private function onSelectGame0 (e:MouseEvent):void {
			closeMenu();
			game = new Game(0, mainStage);
			mainStage.addChild(game);
		}
		
		private function onSelectGame1 (e:MouseEvent):void {
			closeMenu();
			game = new Game(1, mainStage);
			mainStage.addChild(game);
		}
		
		private function onSelectGame2 (e:MouseEvent):void {
			closeMenu();
			game = new Game(2, mainStage);
			mainStage.addChild(game);
		}
		
		private function onSelectExit (e:MouseEvent):void {
			closeMenu();
			fscommand("quit");
			NativeApplication.nativeApplication.exit(0);
		}
		
		private function closeMenu():void{
			SoundMixer.soundTransform = new SoundTransform(0, 0);
			
			this.stage.removeChild(introMovie);
			this.stage.removeChild(button0);
			this.stage.removeChild(button1);
			this.stage.removeChild(button2);
			this.stage.removeChild(buttonExit);
		}
		
	}
}
