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
		private var force:Vector2 = Vector2.Zero;
		private var speed:Vector2 = Vector2.Zero;
		private var pos:Vector2;
		private var frameTime:Number = 0;
		private var attractiveDynamicPoints:Vector.<Loader> = new Vector.<Loader>();
		private var attractiveStaticPoints:Vector.<Vector2> = new Vector.<Vector2>();
		private var attractiveStaticPoint:Vector2;
		private var spaceShip:Loader;
		public const mass:Number = 100;
		
		public function Enemy(stage:Stage, ship:SpaceShip) {
			mainStage = stage;
			spaceShip = ship.spaceShip;
			enemy = new Loader();
			enemy.load(new URLRequest("Enemy.gif"));
			enemy.contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
			attractiveStaticPoint = new Vector2(mainStage.stageWidth/2, mainStage.stageHeight/2);
		}
		
		public function addAttractiveDynamicPoint(point:Loader):void{
			attractiveDynamicPoints.push(point);
		}
		
		public function addAttractiveStaticPoint(point:Vector2):void{
			attractiveStaticPoints.push(point);
		}
		
		
		private function calcForce():void{
			const massOtherDynamic:Number = 500; 
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
		
		private function completeListener (e:Event):void {
        	dispatchEvent(new Event(Event.COMPLETE));
			var scale:Number = 0.2;//Math.random();
			enemy.width = enemy.width * scale;
			enemy.height = enemy.height * scale;
			pos = new Vector2(mainStage.stageWidth-enemy.width, (mainStage.stageHeight-enemy.height)/2);
			enemy.x = pos.X;
			enemy.y = pos.Y;
			setRandomTarget();
			mainStage.addChild(enemy);
			addAttractiveDynamicPoint(spaceShip);
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		protected function enterFrameHandler(event:Event):void{
			var setNewTarget:Boolean = false;
			var dt:Number = getTimer() - frameTime;
			frameTime = getTimer();
			//moveToTarget();
			//curTargetTime += moveSpeed;
		
			//calcForce();
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
