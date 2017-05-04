package assets.histoire
{
	import data2.asxml.ObjectSearch;
	import data2.InterfaceSprite
	import data2.text.Text
	import flash.display.Sprite
	
	public class Component_scrollbar_handle extends InterfaceSprite
	{
		public function Component_scrollbar_handle()
		{
			
		}
		
		public function initComponent(_section:String):void
		{
			var _text0:Text = new Text();
			this.addChild(_text0);
			_text0.width = 134;
			_text0.maxWidth = 134;
			_text0.embedFonts = true;
			//_text0.debugBorder = true;
			_text0.value = "";
			_text0.updateText();
			ObjectSearch.registerID(_text0, "scrollhandle_" + _section + "_text", false);
			
		}
		
	}
	
}

