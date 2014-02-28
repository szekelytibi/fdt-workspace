package com.powerflasher.SampleApp {
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.Stage;

	/**
	 * @author tiborszekely
	 */
	public class Enemy extends Sprite {
		private var enemy:Loader;
		private var mainStage:Stage;
		private var nextTargetX:Number;
		private var nextTargetY:Number;
		private var nextTargetTime:Number;
		private var moveSpeed:Number;
		private var curTargetTime:Number;
		
		public function Enemy(stage:Stage) {
			mainStage = stage;
			enemy = new Loader();
			enemy.load(new URLRequest("Enemy.gif"));
			enemy.contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		private function setRandomTarget(offsetX:int = 0){
			nextTargetTime = 50;//100+Math.random()*200;
			nextTargetX = Math.random() * (mainStage.stageWidth-enemy.width) + offsetX;
			nextTargetY = Math.random() * (mainStage.stageHeight-enemy.height);
			moveSpeed = 1;//0.01 + Math.random() * 0.1;
			curTargetTime = 0;
			if(offsetX != 0){
				enemy.x = nextTargetX;
				enemy.y = nextTargetY;
			}
		}
		
		private function completeListener (e:Event):void {
        	dispatchEvent(new Event(Event.COMPLETE));
			var scale:Number = Math.random();
			enemy.width = enemy.width * scale;
			enemy.height = enemy.height * scale;
			setRandomTarget(mainStage.stageWidth /2);
			mainStage.addChild(enemy);
		}
		
		private function moveToTarget(){
			if(nextTargetTime <= curTargetTime){
				setRandomTarget();
			}
			else{
				var factor:Number = curTargetTime/nextTargetTime; 
			    enemy.x = enemy.x * (1-factor) + nextTargetX * factor;  
			    enemy.y = enemy.y * (1-factor) + nextTargetY * factor;  
			}
		}
		
		protected function enterFrameHandler(event:Event):void{
			moveToTarget();
			curTargetTime += moveSpeed;
		}	
	}
}
