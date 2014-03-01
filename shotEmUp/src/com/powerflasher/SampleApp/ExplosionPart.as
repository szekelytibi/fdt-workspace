package com.powerflasher.SampleApp {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.display.Stage;

	/**
	 * @author tiborszekely
	 */
	public class ExplosionPart extends Loader {
		private var speed:Vector2;
		private var pos:Vector2;
		private var time:Number;
		private var mainStage:Stage;
		public function ExplosionPart(stage:Stage) {
			mainStage = stage;
		}
		
		public function setParams(_center:Vector2, _speed:Vector2, lifeTime:Number):void{
			speed = _speed.mult(0.1);
			time = lifeTime;
			pos = _center;
			this.x = pos.X + speed.X;
			this.y = pos.Y + speed.Y;
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		protected function enterFrameHandler(event:Event):void{
			pos = pos.plus(speed);
			this.x = pos.X;
			this.y = pos.Y;
		}	
	
	}
	
}
