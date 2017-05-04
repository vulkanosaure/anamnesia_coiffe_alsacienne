package assets.collection
{
	import data2.InterfaceSprite
	import data2.mvc.Component;
	import data2.net.imageloader.ImageLoader;
	import data2.text.Text
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite
	
	public class Component_vignette_small extends Component
	{
		private var _is8:Sprite;
		public function Component_vignette_small()
		{
			
		}
		
		
		
		override public function initComponent():void 
		{
			super.initComponent();
			
			_bmp = new Bitmap();
			this.addChild(_bmp);
			_bmp.x = 2; _bmp.y = 2; 
			
			
			
			_is8 = new asset_detail_selected();
			this.addChild(_is8);
			_is8.x = 0; _is8.y = 0; 
			
			var _is2:InterfaceSprite = new InterfaceSprite();
			_is2.addChild(new asset_detail_plus());
			this.addChild(_is2);
			_is2.x = 32; _is2.y = 71;
			
		}
		
		
		
		public function setSelected(_value:Boolean):void
		{
			_is8.visible = _value;
		}
		
		
	}
	
}

