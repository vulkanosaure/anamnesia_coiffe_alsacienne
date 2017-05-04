package assets.collection
{
	import data.display.FilledRectangle;
	import data2.asxml.ObjectSearch;
	import data2.InterfaceSprite
	import data2.mvc.Component;
	import data2.net.imageloader.ImageLoader;
	import data2.text.Text
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class Component_article_listing extends Component
	{
		/*
		private const WIDTH:Number = 170;
		private const HEIGHT:Number = 240;
		*/
		private const WIDTH:Number = 286;
		private const HEIGHT:Number = 280;
		
		
		private var _desc:String;
		private var _text0:Text;
		private var _is0:Sprite;
		public var isVisible:Boolean;
		
		private var _index:int;
		public var indexRaw:int = -1;
		
		
		public function Component_article_listing()
		{
			
		}
		
		override public function initComponent():void
		{
			super.initComponent();
			
			var _marginh:Number = 30;
			var _marginv:Number = 13;
			var _rect:FilledRectangle = new FilledRectangle();
			_rect.width = WIDTH + _marginh * 2;
			_rect.height = HEIGHT + _marginv * 2;
			this.addChild(_rect);
			_rect.x = -_marginh;
			_rect.y = -_marginv;
			_rect.alpha = 0.0;
			
			_is0 = new Sprite();
			this.addChild(_is0);
			
			
			_bmp = new Bitmap();
			_is0.addChild(_bmp);
			
			_text0 = new Text();
			_is0.addChild(_text0);
			_text0.width = WIDTH + 120;
			_text0.embedFonts = true;
			ObjectSearch.registerID(_text0, "text_collection_listing_" + _index, false);
			
			_text0.x = -60; _text0.y = 255;
			
		}
		
		
		
		
		public function set index(value:int):void 
		{
			_index = value;
		}
		
		
		
		
	}
	
}

