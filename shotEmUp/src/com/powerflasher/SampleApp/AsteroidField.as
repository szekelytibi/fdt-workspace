package com.powerflasher.SampleApp {
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
		public function AsteroidField(areaMul:Number, speed:Number, _scale:Number, stage:Stage, callback:Function = null) {
			scale = _scale;
			mainStage = stage;
			fieldSize = mainStage.stageWidth * areaMul;
			scrollSpeed = speed;
			loadingDoneCallback = callback;
			var urls:Vector.<URLRequest> = Vector.<URLRequest>([new URLRequest("Asteroid0.gif"),new URLRequest("Asteroid1.gif"), new URLRequest("Asteroid2.gif"), new URLRequest("Asteroid3.gif"), new URLRequest("Asteroid4.gif"), new URLRequest("Asteroid5.gif"), new URLRequest("Asteroid6.gif"), new URLRequest("Asteroid7.gif"), new URLRequest("Asteroid8.gif"), new URLRequest("Asteroid9.gif")]);
//			var urls:Vector.<URLRequest> = Vector.<URLRequest>([new URLRequest("Asteroid0.gif")]);
			asteroids = new Vector.<Asteroid>();
			var i:int = 0;
			var fieldOffset:Number = mainStage.stageWidth;
			loadedAsteroids = 0;
			for each (var url:URLRequest in urls){
				asteroids[i] = new Asteroid(fieldOffset, fieldSize);
				asteroids[i].load(url);
				asteroids[i].contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
				i++;
			}
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		public function remove():void{
			for each(var asteroid in asteroids){
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
