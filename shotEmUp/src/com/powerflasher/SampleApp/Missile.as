package com.powerflasher.SampleApp {
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	/**
	 * @author tiborszekely
	 */
	public class Missile extends Sprite {
		private var missile:Loader;
		private var emitter:SpaceShip;
		private var initialX:int;
		private var initialY:int;
		private const speed:int = 20;
		private var explosion:Explosion;
		public static var enemyCount:int = 0;
		public function Missile(_emitter:SpaceShip) {
			this.emitter = _emitter;
			missile = new Loader();
			missile.load(new URLRequest("SpaceShip.gif"));
			missile.contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		private function completeListener (e:Event):void {
        	dispatchEvent(new Event(Event.COMPLETE));
			missile.width = missile.width / 3;
			missile.height = missile.height / 6;
			
			if(emitter != null){
				missile.x = emitter.spaceShip.x+emitter.spaceShip.width;
				missile.y = emitter.spaceShip.y+(emitter.spaceShip.height-missile.height)/2;
				emitter.mainStage.addChild(missile);
			}
		}
		
		protected function enterFrameHandler(event:Event):void{
			missile.x += speed;
			var destroyMissile:Boolean = false;
			for each(var enemy:Enemy in Game.instance.enemies) {
				     
       			if (missile.hitTestObject(enemy.enemy)) {
					emitter.mainStage.removeChild(enemy.enemy);
					var index:int = Game.instance.enemies.indexOf(enemy);
					Game.instance.enemies.splice(index, 1);
					destroyMissile = true;
					explosion = new Explosion(emitter.mainStage, missile.x, missile.y, 100, 3);
					if(enemyCount == 0 && Game.instance.enemies.length == 0){
						Game.finish(true);
						trace("CONGRATULATION !");
						// WIN GAME ....
					}
        		}
    		}
			
			if(emitter.mainStage.stageWidth < missile.x)
				destroyMissile = true;
				
			if(destroyMissile){
				emitter.mainStage.removeChild(missile);
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				missile = null;
			}
		}	
	}
}
