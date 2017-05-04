package assets.histoire
{
	import data2.asxml.ObjectSearch;
	import data2.InterfaceSprite
	import data2.text.Text
	import flash.display.Sprite
	import model.translation.Translation;
	
	public class Component_histoire_menuitem extends InterfaceSprite
	{
		//private var _text:String;
		private var _text0:Text;
		private var _index:int;
		private var _section:String;
		
		public function Component_histoire_menuitem()
		{
			
		}
		
		public function initComponent():void
		{
			var _is0:Sprite = new Sprite();
			this.addChild(_is0);
			
			_text0 = new Text();
			_is0.addChild(_text0);
			_text0.width = 220;
			_text0.embedFonts = true;
			_text0.value = "";
			_text0.updateText();
			_text0.x = 18;
			
			trace("registerID(" + _section + "_menuitem_text" + _index + ")");
			Translation.addCallback(_section + "_menuitem_text" + _index, onTextCallback);
			ObjectSearch.registerID(_text0, _section + "_menuitem_text" + _index, true);
			
			var _is1:Sprite = new asset_histoire_menuitem();
			this.addChild(_is1);
			_is1.y = 9;
			
		}
		
		private function onTextCallback(_text:Text):void 
		{
			_text.y = Math.round(-_text.getTextBounds().height * 0.5 + 14);
		}
		
		/*
		public function updateComponent():void
		{
			_text0.value = _text;
			_text0.updateText();
		}
		*/
		
		public function setSelected(_value:Boolean):void
		{
			this.alpha = (_value) ? 1.0 : 0.33;
		}
		
		public function set index(value:int):void 
		{
			_index = value;
		}
		
		public function set section(value:String):void 
		{
			_section = value;
		}
		
		
		/*
		public function set text(value:String):void 
		{
			_text = value;
		}
		*/
		
		
	}
	
}

