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
		
		public function initPosition( _x:int, _y:int):void{
			posX = _x;
			this.x = _x+baseOffset;
			this.y = _y;
		}
		
		public function setOffset(offset:Number):void{
			var _x:int = (posX + offset) % fieldSize;
			this.x = _x + baseOffset;
		}
	}
}
