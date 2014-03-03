package com.powerflasher.SampleApp {
	import flash.display.Shape;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.Stage;

	/**
	 * @author tiborszekely
	 */
	public class Enemy extends Sprite {
		public var enemy:Loader;
		private var mainStage:Stage;
		private var nextTargetTime:Number;
		private var moveSpeed:Number;
		private var curTargetTime:Number;
		private var pos:Vector2;
		private var force:Vector2;
		private var speed:Vector2;
		private var frameTime:Number = 0;
		public static var attractiveDynamicPoint:Loader;
		public static var attractiveStaticPoint:Vector2;
		private var spaceShip:Loader;
		private var id:Number;
		private var radius:int;
		private const PI2:Number = 3.1415926536*2;
		public const mass:Number = 100;
		
//		public static var hitObjs:Vector.<Loader>;
		
		public function Enemy(stage:Stage, ship:SpaceShip, shapeRadius:int, shapeElementId:Number) {
			id = shapeElementId;
			radius = shapeRadius;
			mainStage = stage;
			spaceShip = ship.spaceShip;
			enemy = new Loader();
			enemy.load(new URLRequest("Enemy.gif"));
			enemy.contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
			attractiveStaticPoint = new Vector2(mainStage.stageWidth/2, mainStage.stageHeight/2);
			force = new Vector2(0, 0);
			speed = new Vector2(0, 0);
			
//			hitObjs = new Vector.<Loader>();
		}
		
		private function completeListener (e:Event):void {
        	dispatchEvent(new Event(Event.COMPLETE));
			Game.enemiesDict[enemy] = this;
			var scale:Number = 0.2;//Math.random();
			enemy.width = enemy.width * scale;
			enemy.height = enemy.height * scale;
			if(radius == 0){
				var dPos:Vector2 = new Vector2(radius, radius).rotateEqual(PI2*id);
				pos = dPos.plus(new Vector2((mainStage.stageWidth-enemy.width) - radius, (mainStage.stageHeight-enemy.height)/2));
			}
			else{
				pos = new Vector2(mainStage.stageWidth + 100, Math.random() * mainStage.stageHeight);
			}
			enemy.x = pos.X;
			enemy.y = pos.Y;
			mainStage.addChild(enemy);
//			hitObjs.push(enemy);
			attractiveDynamicPoint = spaceShip;
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		
		
		private function calcDynamicForce():void{
			if(attractiveDynamicPoint){
				const massOtherDynamic:Number = 300; 
				var pOther:Vector2 = new Vector2(attractiveDynamicPoint.x, attractiveDynamicPoint.y);
				var dir:Vector2 = pOther.minus(pos);
				var r2:Number = dir.length();
				var F:Number = (mass*massOtherDynamic)/r2;
				dir.normalizeThis();
				dir.multEquals(F);
				force.plusEquals(dir);
			}
		}
		
		private function calcStaticForce():Boolean{
			const massOtherStatic:Number = 1000; 
			var pOther:Vector2 = attractiveStaticPoint;
			var dir:Vector2 = pOther.minus(pos);
			var r2:Number = dir.length();
			var F:Number = (mass*massOtherStatic)/r2;
			dir.normalizeThis();
			var fVector:Vector2 = dir.mult(F);
			force.X += fVector.X;
			force.Y += fVector.Y;
			//trace(r2);
			return r2 < 100;
		}
		
		private function calcSpeed(dt:Number):void{
			const maxVelocity:Number = 100000;

			speed = force.mult(dt / mass);
			var velocity:Number = Math.min(speed.magnitude(), maxVelocity);
			speed.normalizeThis();
			speed.mult(velocity);
		}

		private function calcPos(dt:Number):void{
			const border:int = 200;
			var step:Vector2 = speed.mult(10); 
			pos.X += step.X;
			pos.Y += step.Y;
			if(pos.X < 2*border){
				force.multEquals(-0.1);
			}
			else if( pos.Y < -border || (mainStage.stageWidth + border) < pos.X || (mainStage.stageHeight + border) < pos.Y){
				speed.X = 0;
				speed.Y = 0;
				var dir:Vector2 = new Vector2;
				dir.X = (spaceShip.x-pos.X)*0.1;
				dir.Y = (spaceShip.y-pos.Y)*0.1;
				force = dir;
			}
		}
		
		
		protected function enterFrameHandler(event:Event):void{
			var dt:Number = getTimer() - frameTime;
			frameTime = getTimer();
		
			calcDynamicForce();
			if(calcStaticForce()){
				setNewTarget();
			}
			calcSpeed(dt);
			calcPos(dt);
			
			enemy.x = pos.X;
			enemy.y = pos.Y;
			
		}
		
		public function kill():void{
			removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		public static function setNewTarget():void{
			attractiveStaticPoint.X = Math.random() * (Game.mainStage.stageWidth);
			attractiveStaticPoint.Y = Math.random() * (Game.mainStage.stageHeight);
		}
	}
}
