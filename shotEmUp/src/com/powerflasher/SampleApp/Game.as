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
		private var enemy:Enemy;
		private var asteroidField0:AsteroidField;
		private var asteroidField1:AsteroidField;
		private var asteroidField2:AsteroidField;
		public function Game(level:int, stage:Stage) {
			mainStage = stage;
			gameLevel = level;
			asteroidField0 = new AsteroidField(2, 4, 1, mainStage, asteroidLayer0Loaded);
			mainStage.addChild(asteroidField0);
		}
		
		private function asteroidLayer0Loaded():void{
			asteroidField1 = new AsteroidField(2, 6, 1, mainStage, asteroidLayer1Loaded);
			mainStage.addChild(asteroidField1);
		}
		
		private function asteroidLayer1Loaded():void{
			spaceShip = new SpaceShip(mainStage);
			mainStage.addChild(spaceShip);
			
			asteroidField2 = new AsteroidField(8, 40, 4, mainStage, null);
			mainStage.addChild(asteroidField2);
			
			enemy = new Enemy(mainStage, spaceShip);
		}
	}
}
