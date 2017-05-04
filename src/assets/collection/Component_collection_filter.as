package assets.collection
{
	import data2.asxml.ObjectSearch;
	import data2.InterfaceSprite
	import data2.text.Text
	import flash.display.Sprite
	import flash.utils.getDefinitionByName;
	
	public class Component_collection_filter extends InterfaceSprite
	{
		private var _index:int;
		private var _text:String;
		
		
		public function Component_collection_filter()
		{
			_text = "";
			_index = 1;
			//initComponent();
		}
		
		public function initComponent():void
		{			
			var _text0:Text = new Text();
			this.addChild(_text0);
			_text0.width = 140;
			_text0.embedFonts = true;
			//_text0.value = "<span class='MS900_15_FFFFFF'>" + _text + "</span>";
			ObjectSearch.registerID(_text0, "text_filter_" + _index, false);
			
			_text0.updateText();
			_text0.x = -40; _text0.y = 70;
			
			var _class:Class = getDefinitionByName("asset_collection_filter") as Class;
			
			var _is1:Sprite = new _class as Sprite;
			this.addChild(_is1);
			_is1.x = 0;
			
		}
		
		public function set index(value:int):void 
		{
			_index = value;
		}
		
		public function set text(value:String):void 
		{
			_text = value;
		}
		
	}
	
}

