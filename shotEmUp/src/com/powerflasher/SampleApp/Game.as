package com.powerflasher.SampleApp {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.Loader;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.events.TimerEvent;


	/**
	 * @author tiborszekely
	 */
	public class Game extends Sprite {
		public var gameLevel:int;
		private var mainStage:Stage;
		private var spaceShip:SpaceShip;
		private var enemies:Vector.<Enemy> = new Vector.<Enemy>();
		private var asteroidField0:AsteroidField;
		private var asteroidField1:AsteroidField;
		private var asteroidField2:AsteroidField;
		private var text:TextField;
		private var finishTimer:Timer = new Timer(200, 20);
		private static var instance:Game;
		private var counter:int;
		
		public function Game(level:int, stage:Stage) {
			instance = this;
			mainStage = stage;
			gameLevel = level;
			asteroidField0 = new AsteroidField(2, 4, 1, mainStage, asteroidLayer0Loaded);
			mainStage.addChild(asteroidField0);
			finishTimer.stop();
			finishTimer.addEventListener(TimerEvent.TIMER, timerHandler);
            finishTimer.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
		}
		
		public static function finish(isWinner:Boolean):void{
			instance.endLevel(isWinner);
		}
		
		public function endLevel(isWinner:Boolean):void{
			text = new TextField();
			text.defaultTextFormat = new TextFormat("_sans", 64, 0xffffff, true);
			if(isWinner){
				text.text = "CONGRATULATION";
				enemies = null;
			}
			else{
				text.text = "GAME OVER";
				spaceShip = null;
			}
			text.x = (mainStage.stageWidth-text.textWidth)/2;
			text.y = (mainStage.stageHeight)/2;
			text.width = text.textWidth;
			mainStage.addChild(text);
			finishTimer.start();
		}
		
		private function removeEnemies():void{
			if(enemies){
				for each(var enemy:Loader in Enemy.hitObjs){
					if(enemy.stage)
						enemy.parent.removeChild(enemy);
				}
				enemies = null;
			}
		}
		
		private function timerHandler(e:TimerEvent):void{
			counter++;
//			trace(counter);
			
			text.visible = counter % 2 == 0;
//			var color:int = Math.random() * 0xffffff;
//			text.defaultTextFormat = new TextFormat("_sans", 48, color, true);
			e.updateAfterEvent();
        }

        private function completeHandler(e:TimerEvent):void {
			mainStage.removeChild(text);
			if(spaceShip)
				spaceShip.remove();
			asteroidField0.remove();
			asteroidField1.remove();
			asteroidField2.remove();
			if(enemies)
				removeEnemies();
			MainMenu.open();
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
			switch(gameLevel){
				case 0:
					createEnemies(3, 60);
					break;
				case 1:
					createEnemies(9, 80);
					break;
				case 2:
					createEnemies(6, 60);
					createEnemies(10, 120);
					break;
			}
		}
		private function createEnemies(numEnemies:int, shapeRadius:int):void{
			for(var i:int = 0; i < numEnemies; i++){
				var enemy:Enemy = new Enemy(mainStage, spaceShip, shapeRadius,  i / numEnemies);
				enemies.push(enemy);
			}
			
		}
	}
}
