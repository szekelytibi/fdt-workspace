package com.powerflasher.SampleApp {
	import mx.charts.chartClasses.NumericAxis;

	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;

	/**
	 * @author tiborszekely
	 */
	public class SpaceShip extends Sprite {
		private var spaceShip : Loader;
		private var numAssets : int = 1;

		public function SpaceShip() {
			spaceShip = new Loader();
			spaceShip.load(new URLRequest("SpaceShip.gif"));
			spaceShip.contentLoaderInfo.addEventListener(Event.COMPLETE, assetLoaded);
		}

		private function assetLoaded(e : Event) : void {
			numAssets--;
			if(numAssets == 0){
				this.stage.addChild(spaceShip);
				
			}
		}
	}
}
