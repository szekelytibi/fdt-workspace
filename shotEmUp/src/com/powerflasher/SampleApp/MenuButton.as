package com.powerflasher.SampleApp {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	/**
	 * @author tiborszekely
	 */
	public class MenuButton extends Sprite {
		private var text : TextField;
		private var icon : Bitmap;
		private var bkg : Shape;
		private var upFormat : TextFormat;
		private var overFormat : TextFormat;

		public function MenuButton(label : String, _icon:Bitmap) {
			buttonMode = true;
			mouseChildren = false;
			upFormat = new TextFormat("_sans", 48, 0x006666, true);
			overFormat = new TextFormat("_sans", 48, 0x009999, true);
			
			
			icon = _icon;
			icon.width = 45;
			icon.height = 45;
			icon.x -= 45;
			icon.y += 6;
			
			text = new TextField();
			text.defaultTextFormat = upFormat;
			text.text = label;
			text.autoSize = TextFieldAutoSize.LEFT;
			text.selectable = false;
			
			var w:int = text.width+icon.width;
			var h:int = text.height;
			bkg = new Shape();
			bkg.graphics.beginFill(0xFFCC00);
            bkg.graphics.lineStyle(0, 0x666666);
            bkg.graphics.drawRect(0, 0, w, h);
            bkg.graphics.endFill();
			bkg.x = icon.x;
			bkg.blendMode = BlendMode.SCREEN;
			bkg.alpha = 0.1;
            addChild(bkg);
			
			bkg.width = text.width+icon.width;
			bkg.height = text.height;
		 
			
			addChild(icon);
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
			bkg.alpha = 0.8;
		}

		public function mouseOutListener(e : MouseEvent) : void {
			text.setTextFormat(upFormat);
			bkg.alpha = 0.1;
		}
	}
}
