package com.powerflasher.SampleApp {
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.Bitmap;

	/**
	 * @author tiborszekely
	 */
	public class Explosion extends Sprite {
		public var center:Vector2 = Vector2.Zero;
		private var parts:Vector.<ExplosionPart>=new Vector.<ExplosionPart>();
		private var radius:int;
		private var numParts:int;
		private var mainStage:Stage;
		private var time:Number;
		
		[Embed (source="assets/ShipExplosion.gif" )]
		public static const shipExplosionAsset:Class;
		[Embed (source="assets/EnemyExplosion.gif" )]
		public static const enemyExplosionAsset:Class;
		
		
		public function Explosion( stage:Stage, cx:int, cy:int, _radius:int, _numParts:int, type:int = 0){
			mainStage = stage;
			numParts = _numParts;
			radius = _radius;
			center = new Vector2(cx, cy);
			var bmpSE:Bitmap = new shipExplosionAsset();
			var bmpEE:Bitmap = new enemyExplosionAsset();
			for(var i:int = 0; i < numParts; i++){
				var part:ExplosionPart = new ExplosionPart(mainStage);
				parts.push(part);
				if(type == 1){
					time = 2000;
					part.bitmapData = bmpSE.bitmapData; 
				}
				else{
					time = 1000;
					part.bitmapData = bmpEE.bitmapData; 
				}
				
				part.width = radius/2;
				part.height = radius/2;
				var rad:Number = Math.PI*2* i/parts.length;
				var dir:Vector2 = new Vector2(radius, radius).rotateEqual(rad);
				part.setParams(center,dir, 1000);
				mainStage.addChild(part);
			}
		}
	}
}

