package com.powerflasher.SampleApp {
	import flash.geom.Rectangle;
	import flash.display.Screen;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import mx.core.Window;

	/**
	 * @author tiborszekely
	 */
	public class Main extends Sprite {
		private var _tf:TextField;
		private var button0:MenuButton;
		private var button1:MenuButton;
		private var button2:MenuButton;
		public function Main() {
			trace(this.stage.stageWidth);
			trace(this.stage.stageHeight);
			button0 = new MenuButton("Game 1");
			button0.addEventListener(MouseEvent.CLICK, onSelectGame0);
			addChild(button0);
			
			button1 = new MenuButton("Game 2");
			button1.addEventListener(MouseEvent.CLICK, onSelectGame1);
			addChild(button1);
			
			button2 = new MenuButton("Game 3");
			button2.addEventListener(MouseEvent.CLICK, onSelectGame2);
			addChild(button2);
			
			var x:int = this.stage.stageWidth / 2;
			var y:int = this.stage.stageHeight / 2 - (button0.height + button1.height + button2.height) / 2;
			
			button0.setPos(x, y);
			y += button0.height;
			button1.setPos(x, y);
			y += button1.height;
			button2.setPos(x, y);
			
			
			_tf = new TextField();
            _tf.text = "!@!";
           
            _tf.autoSize = TextFieldAutoSize.CENTER;   
            _tf.x = (stage.stageWidth - _tf.width) / 2;
            _tf.y = (stage.stageHeight - _tf.height) / 2;   
 
//            addChild(_tf);
		}
		
		private function onSelectGame0 (e:MouseEvent):void {
		}
		
		private function onSelectGame1 (e:MouseEvent):void {
		}
		
		private function onSelectGame2 (e:MouseEvent):void {
		}
	}
	
}
