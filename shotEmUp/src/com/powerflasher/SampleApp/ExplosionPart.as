package com.powerflasher.SampleApp {
	import flash.utils.getTimer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.BlendMode;

	/**
	 * @author tiborszekely
	 */
	public class ExplosionPart extends Loader {
		private var speed:Vector2;
		private var pos:Vector2;
		private var time:Number;
		private var startTime:Number;
		private var mainStage:Stage;
		private var startWidth:int;
		private var startHeight:int;
		public function ExplosionPart(stage:Stage) {
			mainStage = stage;
		}
		
		public function setParams(_center:Vector2, _speed:Vector2, lifeTime:Number):void{
			speed = _speed.mult(0.1);
			time = lifeTime;
			pos = _center;
			this.x = pos.X + speed.X;
			this.y = pos.Y + speed.Y;
			this.blendMode = BlendMode.SCREEN;
			startTime = getTimer();
			startWidth = this.width;
			startHeight = this.height;
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		protected function enterFrameHandler(event:Event):void{
			var factor:Number = (getTimer()-startTime) / time;
			if(getTimer()-startTime < time){
				pos = pos.plus(speed.mult(0.1));
				this.alpha = 1-factor;
				this.width = startWidth*(1+5*factor);
				this.height = startHeight*(1+5*factor);
				this.x = pos.X-this.width/2;
				this.y = pos.Y-this.height/2;
			}
			else{
				mainStage.removeChild(this);
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}	
	
	}
	
}
