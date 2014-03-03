package com.powerflasher.SampleApp {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import mx.controls.Image;
	/**
	 * @author tiborszekely
	 */
	public class MenuButton extends Sprite {
		private var text : TextField;
		private var icon : Image;
		private var upFormat : TextFormat;
		private var overFormat : TextFormat;

		public function MenuButton(label : String, _icon:Class) {
			buttonMode = true;
			mouseChildren = false;
			upFormat = new TextFormat("_sans", 24, 0x006666, true);
			overFormat = new TextFormat("_sans", 24, 0x009999, true);
			
//			icon = new Image();
//			icon.source = _icon;
			
			text = new TextField();
			text.defaultTextFormat = upFormat;
			text.text = label;
			text.autoSize = TextFieldAutoSize.CENTER;
			text.selectable = false;
//			addChild(icon);
			addChild(text);
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverListener);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutListener);
		}
		
		public function setPos(posX : int, posY : int) : void{
			this.x = posX-text.width/2;
			this.y = posY;
		}

		public function disable() : void {
			mouseEnabled = false;
		}

		public function mouseOverListener(e : MouseEvent) : void {
			text.setTextFormat(overFormat);
		}

		public function mouseOutListener(e : MouseEvent) : void {
			text.setTextFormat(upFormat);
		}
	}
}
