package com.powerflasher.SampleApp {
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
		private var enemy:Loader;
		private var mainStage:Stage;
		private var nextTargetX:Number;
		private var nextTargetY:Number;
		private var nextTargetTime:Number;
		private var moveSpeed:Number;
		private var curTargetTime:Number;
		private var pos:Vector2;
		private var force:Vector2 = Vector2.Zero;
		private var speed:Vector2 = Vector2.Zero;
		private var frameTime:Number = 0;
		private var attractiveDynamicPoints:Vector.<Loader> = new Vector.<Loader>();
		private var attractiveStaticPoints:Vector.<Vector2> = new Vector.<Vector2>();
		private var attractiveStaticPoint:Vector2;
		private var spaceShip:Loader;
		private var id:Number;
		private var radius:int;
		private const PI2:Number = 3.1415926536*2;
		public const mass:Number = 100;
		
		public static var hitObjs:Vector.<Loader>;
		
		public function Enemy(stage:Stage, ship:SpaceShip, shapeRadius:int, shapeElementId:Number) {
			id = shapeElementId;
			radius = shapeRadius;
			mainStage = stage;
			spaceShip = ship.spaceShip;
			enemy = new Loader();
			enemy.load(new URLRequest("Enemy.gif"));
			enemy.contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
			attractiveStaticPoint = new Vector2(mainStage.stageWidth/2, mainStage.stageHeight/2);
			hitObjs = new Vector.<Loader>();
		}
		
		private function completeListener (e:Event):void {
        	dispatchEvent(new Event(Event.COMPLETE));
			var scale:Number = 0.2;//Math.random();
			enemy.width = enemy.width * scale;
			enemy.height = enemy.height * scale;
			var dPos:Vector2 = new Vector2(radius, radius).rotateEqual(PI2*id);
			pos = new Vector2((mainStage.stageWidth-enemy.width) - radius, (mainStage.stageHeight-enemy.height)/2);
			pos.plusEquals(dPos);
			enemy.x = pos.X;
			enemy.y = pos.Y;
			setRandomTarget();
			mainStage.addChild(enemy);
			hitObjs.push(enemy);
			addAttractiveDynamicPoint(spaceShip);
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		
		public function addAttractiveDynamicPoint(point:Loader):void{
			attractiveDynamicPoints.push(point);
		}
		
		public function addAttractiveStaticPoint(point:Vector2):void{
			attractiveStaticPoints.push(point);
		}
		
		private function calcForce():void{
			const massOtherDynamic:Number = 1000; 
			if(attractiveDynamicPoints.length == 0){
				force = Vector2.Zero;
				trace("ZERO");
			}
			for each(var point:Loader in attractiveDynamicPoints){
				var pOther:Vector2 = new Vector2(point.x, point.y);
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
			dir.multEquals(F);
			force.plusEquals(dir);
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
			pos.plusEquals(speed.mult(10));
			if(pos.X < 0 || pos.Y < 0 || mainStage.stageWidth < pos.X || mainStage.stageHeight < pos.Y){
				speed.X = 0;
				speed.Y = 0;
				force.multEquals(0.1);
			}
		}
		
		private function setRandomTarget():void{
			nextTargetTime = 50;//100+Math.random()*200;
			nextTargetX = Math.random() * (mainStage.stageWidth-enemy.width);
			nextTargetY = Math.random() * (mainStage.stageHeight-enemy.height);
			moveSpeed = 1;
			curTargetTime = 0;
		}
		
		protected function enterFrameHandler(event:Event):void{
			var setNewTarget:Boolean = false;
			var dt:Number = getTimer() - frameTime;
			frameTime = getTimer();
			//moveToTarget();
			//curTargetTime += moveSpeed;
		
			calcForce();
			setNewTarget = calcStaticForce();
			calcSpeed(dt);
			calcPos(dt);
			
			enemy.x = pos.X;
			enemy.y = pos.Y;
			
			if(setNewTarget){
				attractiveStaticPoint.X = Math.random() * (mainStage.stageWidth - enemy.width);
				attractiveStaticPoint.Y = Math.random() * (mainStage.stageHeight - enemy.height);
				force.multEquals(0.01);
//				trace(attractiveStaticPoint);
			}
		}
	}
}
