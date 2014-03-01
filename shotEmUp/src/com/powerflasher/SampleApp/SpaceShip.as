package com.powerflasher.SampleApp {

	import flash.utils.getTimer;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * @author tiborszekely
	 */
	public class SpaceShip extends Sprite {
		private var numAssets : int = 1;
		
		public var spaceShip : Loader;
		public var mainStage:Stage;
		public var up:Boolean = false;
		public var down:Boolean = false;
		public var left:Boolean = false;
		public var right:Boolean = false;
		public var fire:Boolean = false;
		private var lastFireTime:Number = 0;
		private const fireChargeTime:Number = 500;
		
		// Animation
		public var hSpeed:Number = 20;
		public var vSpeed:Number = 10;
		

		public function SpaceShip(stage:Stage) {
			mainStage = stage;
			spaceShip = new Loader();
			spaceShip.load(new URLRequest("SpaceShip.gif"));
			spaceShip.contentLoaderInfo.addEventListener(Event.COMPLETE, assetLoaded);
			
			mainStage.addEventListener(KeyboardEvent.KEY_DOWN,keyPressHandler);
			mainStage.addEventListener(KeyboardEvent.KEY_UP,keyReleaseHandler);
			// Update screen every frame
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
			
		}
		
		public function remove():void{
			mainStage.removeChild(spaceShip);
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			mainStage.removeEventListener(KeyboardEvent.KEY_DOWN,keyPressHandler);
			mainStage.removeEventListener(KeyboardEvent.KEY_UP,keyReleaseHandler);
		}

		private function assetLoaded(e : Event) : void {
			numAssets--;
			if(numAssets == 0){
				this.stage.addChild(spaceShip);
				var scale:Number = 0.6;//Math.random();
				spaceShip.width = spaceShip.width * scale;
				spaceShip.height = spaceShip.height * scale;
				spaceShip.y = this.stage.stageHeight/2-spaceShip.height/2;
			}
		}
		
		protected function enterFrameHandler(event:Event):void
		{
			
			if(fire && ((lastFireTime+fireChargeTime) < getTimer())){
				lastFireTime = getTimer();
				var missile:Missile = new Missile(this);
				fire = false;
			}
			// Move up, down, left, or right
			if( left && !right ) {
				spaceShip.x -= hSpeed;
			}
			if( right && !left ) {
				spaceShip.x += hSpeed;
			}
			if( up && !down ) {
				spaceShip.y -= vSpeed;
			}
			if( down && !up ) {
				spaceShip.y += vSpeed;
			}
			// Loop to opposite side of the masked 
			// area when the beetle travels off-screen.
			var minY:int = 0;
			var maxY:int = mainStage.stageHeight-spaceShip.height;
			var minX:int = 0;
			var maxX:int = mainStage.stageWidth-spaceShip.width;
			
			if( spaceShip.y < minY ){
				spaceShip.y = minY;
			}
			if( spaceShip.y > maxY ){
				spaceShip.y = maxY;
			}
			if( spaceShip.x < minX ){
				spaceShip.x = minX;
			}
			if( spaceShip.x > maxX ){
				spaceShip.x = maxX;
			}
			
			for each(var enemy:Loader in Enemy.hitObjs) {     
       			if (spaceShip.hitTestObject(enemy)) {
					var explosion:Explosion = new Explosion(mainStage, enemy.x, enemy.y, 100, 6, 1);
					if(enemy.stage){
						enemy.parent.removeChild(enemy);
					}
					remove();
					Game.finish(false);
					trace("GAME OVER");
					return;
        		}
    		}
			
		}
		
		protected function keyPressHandler(event:KeyboardEvent):void
		{
			switch( event.keyCode )
			{
				case Keyboard.UP:
					up = true;
					break;
					
				case Keyboard.DOWN:
					down = true;
					break;
					
				case Keyboard.LEFT:
					left = true;
					break;
					
				case Keyboard.RIGHT:
					right = true;
					break;
					
				case Keyboard.SPACE:
					fire = true;
					break;
			}
		}
		
		protected function keyReleaseHandler(event:KeyboardEvent):void
		{
			switch( event.keyCode )
			{
				case Keyboard.UP:
					up = false;
					break;
					
				case Keyboard.DOWN:
					down = false;
					break;
					
				case Keyboard.LEFT:
					left = false;
					break;
					
				case Keyboard.RIGHT:
					right = false;
					break;
				case Keyboard.SPACE:
					fire = false;
					break;
					
			}
		}
	}
}
