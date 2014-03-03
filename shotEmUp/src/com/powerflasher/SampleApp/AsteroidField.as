package com.powerflasher.SampleApp {
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author tiborszekely
	 */
	public class AsteroidField extends Sprite {
		private var asteroids:Vector.<Asteroid>;
		private var mainStage:Stage;
		private var loadedAsteroids:int = 0;
		private var loadingDoneCallback:Function;
		public var scrollSpeed:Number = 0;
		private var fieldSize:Number;
		private var scrollOffset:Number = 0;
		private var scale:Number;
		
		[Embed (source="assets/Asteroid0.gif" )]
		public static const asteroid0Asset:Class;
		[Embed (source="assets/Asteroid1.gif" )]
		public static const asteroid1Asset:Class;
		[Embed (source="assets/Asteroid2.gif" )]
		public static const asteroid2Asset:Class;
		[Embed (source="assets/Asteroid3.gif" )]
		public static const asteroid3Asset:Class;
		[Embed (source="assets/Asteroid4.gif" )]
		public static const asteroid4Asset:Class;
		[Embed (source="assets/Asteroid5.gif" )]
		public static const asteroid5Asset:Class;
		[Embed (source="assets/Asteroid6.gif" )]
		public static const asteroid6Asset:Class;
		[Embed (source="assets/Asteroid7.gif" )]
		public static const asteroid7Asset:Class;
		[Embed (source="assets/Asteroid8.gif" )]
		public static const asteroid8Asset:Class;
		[Embed (source="assets/Asteroid9.gif" )]
		public static const asteroid9Asset:Class;
		
		public function AsteroidField(areaMul:Number, speed:Number, _scale:Number, stage:Stage, callback:Function = null) {
			scale = _scale;
			mainStage = stage;
			fieldSize = mainStage.stageWidth * areaMul;
			scrollSpeed = speed;
			loadingDoneCallback = callback;
			var assets:Vector.<Class> = Vector.<Class>([asteroid0Asset, asteroid1Asset, asteroid2Asset, asteroid3Asset, asteroid4Asset, asteroid5Asset, asteroid6Asset, asteroid7Asset, asteroid8Asset, asteroid9Asset]);
			asteroids = new Vector.<Asteroid>();
			var i:int = 0;
			var fieldOffset:Number = mainStage.stageWidth;
			loadedAsteroids = 0;
			for each (var asset:Class in assets){
				var bmp:Bitmap = new asset();
				asteroids[i] = new Asteroid(fieldOffset, fieldSize);
				asteroids[i].bitmapData = bmp.bitmapData;
				mainStage.addChild(asteroids[i]);
				asteroids[i].initPosition(Math.random() * fieldSize, Math.random() * mainStage.stageHeight, scale);
			}
			if(loadingDoneCallback != null)
				loadingDoneCallback();
			
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		public function remove():void{
			for each(var asteroid:Asteroid in asteroids){
				mainStage.removeChild(asteroid);
			}
		}
		
		protected function enterFrameHandler(event:Event):void{
			scrollOffset += scrollSpeed;
							
			for each(var asteroid:Asteroid in asteroids){
				asteroid.setOffset(-scrollOffset);
			}
		}
		
		private function completeListener (e:Event):void {
			loadedAsteroids++;
			if(loadedAsteroids == asteroids.length){
				for each(var asteroid:Asteroid in asteroids){
					mainStage.addChild(asteroid);
					asteroid.initPosition(Math.random() * fieldSize, Math.random() * mainStage.stageHeight, scale);
				}
				if(loadingDoneCallback != null)
					loadingDoneCallback();
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}
