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
			for each(var enemy:Loader in Enemy.hitObjs) {     
       			if (missile.hitTestObject(enemy)) {
					emitter.mainStage.removeChild(enemy);
					var index:int = Enemy.hitObjs.indexOf(enemy);
					Enemy.hitObjs.splice(index, 1);
					destroyMissile = true;
					
					if(Enemy.hitObjs.length ==0){
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
