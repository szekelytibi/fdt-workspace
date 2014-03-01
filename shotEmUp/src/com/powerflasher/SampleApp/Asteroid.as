package com.powerflasher.SampleApp {
	import flash.display.Loader;

	/**
	 * @author tiborszekely
	 */
	public class Asteroid extends Loader {
		public var posX:int;
		private var fieldSize:Number;
		private var baseOffset:Number;
		public function Asteroid(_baseOffset:int, _fieldSize:int) {
			this.fieldSize = _fieldSize;
			this.baseOffset = _baseOffset;
		}
		
		public function initPosition( _x:int, _y:int, _scale:Number = 1):void{
			posX = _x;
			this.x = _x+baseOffset;
			this.y = _y;
			this.width *= _scale;
			this.height *= _scale;
		}
		
		public function setOffset(offset:Number):void{
			var _x:int = (posX + offset) % fieldSize;
			this.x = _x + baseOffset;
		}
	}
}
