package com.powerflasher.SampleApp {
	import flash.net.URLRequest;
	import mx.core.Container;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.ErrorEvent;
    import flash.events.UncaughtErrorEvent;
	import flash.display.Sprite;

	/**
	 * @author tiborszekely
	 */
	public class AsteroidField extends Sprite {
		private var asteroids:Vector.<Loader>;
		private var mainStage:Stage;
		private var loadedAsteroids:int = 0;
		private var asteroid0:Loader; 
		private var asteroid1:Loader; 
		public function AsteroidField(stage:Stage) {
			trace(this);
			mainStage = stage;
			var urls:Vector.<URLRequest> = Vector.<URLRequest>([new URLRequest("Asteroid0.gif"),new URLRequest("Asteroid1.gif"), new URLRequest("Asteroid2.gif"), new URLRequest("Asteroid3.gif"), new URLRequest("Asteroid4.gif"), new URLRequest("Asteroid5.gif"), new URLRequest("Asteroid6.gif"), new URLRequest("Asteroid7.gif"), new URLRequest("Asteroid8.gif"), new URLRequest("Asteroid9.gif")]);
			asteroids = new Vector.<Loader>();
			var i:int = 0;
			
			for each (var url:URLRequest in urls){
				asteroids[i] = new Loader();
				asteroids[i].load(url);
				asteroids[i].contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
				i++;
			}
		}
		
		private function completeListener (e:Event):void {
			loadedAsteroids++;
			if(loadedAsteroids == asteroids.length){
				trace("ALL LOADED");
				for each(var asteroid:Loader in asteroids){
					mainStage.addChild(asteroid);
					asteroid.x = Math.random() * mainStage.stageWidth;
					asteroid.y = Math.random() * mainStage.stageHeight;
				}
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function uncaughtErrorHandler(event:UncaughtErrorEvent):void{
			trace("ERROR:", event);
            if (event.error is Error)
            {
                var error:Error = event.error as Error;
                // do something with the error
            }
            else if (event.error is ErrorEvent)
            {
                var errorEvent:ErrorEvent = event.error as ErrorEvent;
                // do something with the error
            }
            else
            {
                // a non-Error, non-ErrorEvent type was thrown and uncaught
            }
        }
	}
}
