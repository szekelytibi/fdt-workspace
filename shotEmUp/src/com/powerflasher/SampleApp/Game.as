package com.powerflasher.SampleApp {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.events.TimerEvent;


	/**
	 * @author tiborszekely
	 */
	public class Game extends Sprite {
		public var gameLevel:int;
		public static var mainStage:Stage;
		private var spaceShip:SpaceShip;
		public var enemies:Vector.<Enemy>;
		private var asteroidField0:AsteroidField;
		private var asteroidField1:AsteroidField;
		private var asteroidField2:AsteroidField;
		private var text:TextField;
		private var finishTimer:Timer = new Timer(200, 20);
		private var newTargetTimer:Timer = new Timer(3000);
		private var enemyTimer:Timer = new Timer(2000, 10);
		private var counter:int;
		public static var instance:Game;
		public static var massStatic:Sprite;
		public static var massDynamic:Sprite;
		
		public static const displayMasses:Boolean = false;
		
		public function Game(level:int, stage:Stage) {
			instance = this;
			mainStage = stage;
			gameLevel = level;
			finishTimer.stop();
			finishTimer.addEventListener(TimerEvent.TIMER, timerHandler);
            finishTimer.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
			
			enemyTimer.stop();
			enemyTimer.addEventListener(TimerEvent.TIMER, enemyTimerHandler);
            enemyTimer.addEventListener(TimerEvent.TIMER_COMPLETE, enemyTimerCompleteHandler);
			
			newTargetTimer.stop();
			newTargetTimer.addEventListener(TimerEvent.TIMER, newTargetTimerHandler);
			
			asteroidField0 = new AsteroidField(2, 4, 1, mainStage, asteroidLayer0Loaded);
			mainStage.addChild(asteroidField0);
			

			if(displayMasses){
				massStatic = new Sprite();
				massStatic.graphics.beginFill(0xFFCC00);
				massStatic.graphics.drawCircle(20, 20, 20);
				
				massDynamic = new Sprite();
				massDynamic.graphics.beginFill(0xFF00CC);
				massDynamic.graphics.drawCircle(20, 20, 20);
				
				massDynamic.x = 100;
				massDynamic.y = 200;
				
				massStatic.x = 400;
				massStatic.y = 200;
				mainStage.addChild(massDynamic);
				mainStage.addChild(massStatic);
			}
			
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
			enemyTimer.stop();
			removeEventListener(TimerEvent.TIMER, enemyTimerHandler);
            removeEventListener(TimerEvent.TIMER_COMPLETE, enemyTimerCompleteHandler);
			text.x = (mainStage.stageWidth-text.textWidth)/2;
			text.y = (mainStage.stageHeight)/2;
			text.width = text.textWidth;
			mainStage.addChild(text);
			newTargetTimer.stop();
			finishTimer.start();
			if(Game.displayMasses){
				mainStage.removeChild(massStatic);
				mainStage.removeChild(massDynamic);
			}
			killEnemies();
		}
		
		private function newTargetTimerHandler(e:TimerEvent):void{
			Enemy.setNewTarget();
        }
		
		
		private function timerHandler(e:TimerEvent):void{
			counter++;
			
			text.visible = counter % 2 == 0;
			e.updateAfterEvent();
        }

        private function completeHandler(e:TimerEvent):void {
			mainStage.removeChild(text);
			if(spaceShip)
				spaceShip.remove();
			asteroidField0.remove();
			asteroidField1.remove();
			asteroidField2.remove();
			killEnemies();
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
			enemies = new Vector.<Enemy>();
			switch(gameLevel){
				case 0:
					createEnemies(1, 60);
					enemyTimer.start();
					Missile.enemyCount = 10;
					break;
				case 1:
					createEnemies(10, 80);
					Missile.enemyCount = 0;
					break;
				case 2:
					createEnemies(6, 60);
					createEnemies(10, 120);
					Missile.enemyCount = 0;
					break;
			}
			newTargetTimer.start();
		}
		
		private function createEnemies(numEnemies:int, shapeRadius:int):void{
			for(var i:int = 0; i < numEnemies; i++){
				var enemy:Enemy = new Enemy(mainStage, spaceShip, shapeRadius,  i / numEnemies);
				enemies.push(enemy);
			}
		}
		
		public function killEnemies():void{
			for each(var enemy:Enemy in enemies){
				enemy.remove();
			}
			enemies = new Vector.<Enemy>();
		}
		
		public function killEnemy(enemy:Enemy):void{
			enemy.remove();
			var index:int = Game.instance.enemies.indexOf(enemy);
			Game.instance.enemies.splice(index, 1);
		}
		
		private function enemyTimerHandler(e:TimerEvent):void{
			createEnemies(1, 0);
        }

        private function enemyTimerCompleteHandler(e:TimerEvent):void {
			Game.finish(true);
			trace("CONGRATULATION !");
        }
		
	}
}
