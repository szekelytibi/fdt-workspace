package com.powerflasher.SampleApp {
	import flash.display.Sprite;
	import flash.display.Stage;

	/**
	 * @author tiborszekely
	 */
	public class Game extends Sprite {
		public var gameLevel:int;
		private var mainStage:Stage;
		private var spaceShip:SpaceShip;
		private var asteroidField0:AsteroidField;
		private var asteroidField1:AsteroidField;
		public function Game(level:int, stage:Stage) {
			mainStage = stage;
			gameLevel = level;
			trace(level);
			asteroidField0 = new AsteroidField(2, 4, mainStage, asteroidsAreLoaded);
			mainStage.addChild(asteroidField0);
		}
		
		private function asteroidsAreLoaded():void{
			spaceShip = new SpaceShip(mainStage);
			mainStage.addChild(spaceShip);
			
			asteroidField1 = new AsteroidField(2, 6, mainStage, null);
			mainStage.addChild(asteroidField1);
			
		}
	}
}
