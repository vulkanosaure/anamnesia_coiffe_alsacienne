package assets.gamecoiffe
{
	import data.display.FilledRectangle;
	import data2.asxml.ObjectSearch;
	import data2.InterfaceSprite
	import data2.text.Text
	import flash.display.Sprite
	
	public class Component_solution_item extends InterfaceSprite
	{
		private var _bg:FilledRectangle;
		private var _index:int;
		
		public function Component_solution_item()
		{
			
		}
		
		public function initComponent():void
		{
			_bg = new FilledRectangle();
			this.addChild(_bg);
			_bg.width = 1048;
			_bg.height = 70;
			
			var _is1:Sprite = new Sprite();
			this.addChild(_is1);
			
			var _text0:Text = new Text();
			this.addChild(_text0);
			_text0.width = 880;
			_text0.embedFonts = true;
			_text0.value = "<span class='FRM_19_FFFFFF'>Nunc dapibus libero id diam fringilla, at dignissim dolor euismod.</span>";
			_text0.updateText();
			_text0.x = 84; _text0.y = 23;
			ObjectSearch.registerID(_text0, "quizz_solution_" + _index, false);
			
			trace("initComponent(" + _index + ")");
			
			
			
		}
		
		public function setSelected(_value:Boolean):void
		{
			_bg.color = (_value) ? 0x458689 : 0x79c1c9;
			
		}
		
		public function set index(value:int):void 
		{
			_index = value;
		}
		
	}
	
}

