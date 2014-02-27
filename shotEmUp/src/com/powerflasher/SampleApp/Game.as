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
		public function Game(level:int, stage:Stage) {
			mainStage = stage;
			gameLevel = level;
			spaceShip = new SpaceShip(mainStage);
			mainStage.addChild(spaceShip);
		}
	}
}
