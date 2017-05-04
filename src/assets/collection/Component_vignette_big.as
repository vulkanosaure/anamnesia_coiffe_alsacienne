package assets.collection
{
	import data.display.FilledRectangle;
	import data2.InterfaceSprite
	import data2.mvc.Component;
	import data2.net.imageloader.ImageLoader;
	import data2.text.Text
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite
	import flash.events.Event;
	
	public class Component_vignette_big extends Component
	{
		
		public function Component_vignette_big()
		{
			initComponent();
		}
		
		override public function initComponent():void
		{
			super.initComponent();
			
			var _marginbg:Number = 200;
			
			var _bg:FilledRectangle = new FilledRectangle(0xff0000);
			_bg.alpha = 0.0;
			this.addChild(_bg);
			_bg.width = 624 + 2 * _marginbg;
			_bg.height = 620 + 2 * _marginbg;
			_bg.x = -_marginbg;
			_bg.y = -_marginbg;
			
			
			
			_bmp = new Bitmap();
			this.addChild(_bmp);
			_bmp.smoothing = false;
			
			
			
			var _btnclose:InterfaceSprite = new InterfaceSprite();
			
			var _is4:Sprite = new asset_close_detail();
			this.addChild(_btnclose);
			_btnclose.addChild(_is4);
			_btnclose.x = 286; _btnclose.y = 586; 
			_btnclose.clickableMargin = 27;
			_btnclose.clickableMargin_top = 60;
			_btnclose.clickableMargin_horiz = 60;
			_btnclose.onmousedown = "as:#ascodecollection  onCloseVignette";
			_btnclose.initOnClick(0);
			
			
			
		}
		
		
		
		
		
		
		
	}
	
}

