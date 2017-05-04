package assets.compose
{
	import data2.asxml.ObjectSearch;
	import data2.InterfaceSprite
	import data2.text.Text
	import flash.display.DisplayObject;
	import flash.display.Sprite
	
	public class Component_compose_choice extends InterfaceSprite
	{
		public var index:int;
		private const WIDTH:int = 80;
		private const HEIGHT:int = 80;
		private var _iconContainer:Sprite;
		private var _spriteSelected:Sprite;
		public var imgbig:String;
		public var situation:String;
		public var end:Boolean;
		public var nofile:Boolean = false;
		
		public function Component_compose_choice()
		{
			
		}
		
		public function initComponent():void
		{
			/*
			var _is0:Sprite = new asset_compose_itemchoice();
			this.addChild(_is0);
			_is0.x = 0; _is0.y = 0; 
			
			var _is4:Sprite = new asset_compose_itemchoice_selected();
			this.addChild(_is4);
			_is4.x = 0; _is4.y = 0; 
			*/
			
			
			var _bg:Sprite = new item_choice_bg();
			this.addChild(_bg);
			_bg.x = _bg.y = 4;
			
			this.layoutWidth = WIDTH;
			this.layoutHeight = HEIGHT;
			
			
			_iconContainer = new Sprite();
			this.addChild(_iconContainer);
			
			var _text0:Text = new Text();
			this.addChild(_text0);
			_text0.width = 200;
			_text0.embedFonts = true;
			_text0.value = "<span class='FRB_15_646475'>Type 1</span>";
			//_text0.debugBorder = true;
			_text0.updateText();
			ObjectSearch.registerID(_text0, "text_item_compose_" + index, false);
			_text0.x = Math.round(WIDTH * 0.5 - _text0.width * 0.5);
			_text0.y = HEIGHT + 5; 
			
			
			_spriteSelected = new asset_compose_itemchoice_selected();
			this.addChild(_spriteSelected);
			_spriteSelected.x = 0; _spriteSelected.y = 0; 
			
		}
		
		public function setIcon(_icon:DisplayObject):void 
		{
			//trace("setIcon(" + _icon + ")");
			while (_iconContainer.numChildren) _iconContainer.removeChildAt(0);
			_iconContainer.addChild(_icon);
			
		}
		
		public function setSelected(_value:Boolean):void
		{
			_spriteSelected.visible = _value;
		}
		
	}
	
}

