package assets.histoire 
{
	import data2.asxml.ObjectSearch;
	import data2.InterfaceSprite;
	import data2.mvc.Component;
	import data2.text.Text;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Vinc
	 */
	public class Component_histoire_text extends Component
	{
		private var _index:int;
		private var _section:String;
		
		public function Component_histoire_text() 
		{
			
		}
		
		override public function initComponent():void 
		{
			super.initComponent();
			 
			_bmp = new Bitmap();
			this.addChild(_bmp);
			_bmp.x = 428;
			_bmp.y = 77;
			
			
			var _text0:Text = new Text();
			addChild(_text0);
			_text0.width = 393;
			_text0.embedFonts = true;
			ObjectSearch.registerID(_text0, "text_" + _section + "_" + _index, true);
			
			var _legend:Text = new Text();
			addChild(_legend);
			_legend.width = 480;
			_legend.embedFonts = true;
			_legend.multiline = true;
			_legend.x = 428; _legend.y = 696;
			ObjectSearch.registerID(_legend, "text_" + _section + "_legend_" + _index, true);
			
			
		}
		
		
		
		public function set index(value:int):void 
		{
			_index = value;
		}
		
		public function set section(value:String):void 
		{
			_section = value;
		}
		
	}

}