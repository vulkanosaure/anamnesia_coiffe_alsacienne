package data2.mvc 
{
	import data2.InterfaceSprite;
	import data2.net.imageloader.ImageLoader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	/**
	 * ...
	 * @author Vinc
	 */
	public class Component extends InterfaceSprite
	{
		private var _urlimg:String;
		
		private var _loader:Loader;
		private var _bmpd:BitmapData;
		protected var _bmp:Bitmap;
		
		
		public function Component() 
		{
			
		}
		
		
		
		public function initComponent():void
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
		}
		
		public function updateComponent(_updateimg:Boolean = true):void
		{
			if (_loader == null) throw new Error("initComponent has not been called");
			var _img:DisplayObject = ImageLoader.getImage(_urlimg);
			
			if (_img != null) {
				
				var _bmp:Bitmap = Bitmap(_img);
				_bmpd = _bmp.bitmapData;
				if(_updateimg) updateImg();
				
				trace("updateComponent :: already loaded : " + _urlimg);
			}
			else {
				trace("updateComponent :: must load : " + _urlimg);
				ImageLoader.add(_loader, _urlimg);
			}
		}
		
		
		
		
		private function onLoaderComplete(e:Event):void 
		{
			var _loader:Loader = LoaderInfo(e.target).loader;
			_bmpd = (_loader.content as Bitmap).bitmapData;
			
			//trace("onLoaderComplete " + _bmpd);
			updateImg();
		}
		
		private function updateImg():void 
		{
			_bmp.bitmapData = _bmpd;
		}
		
		
		
		
		public function set urlimg(value:String):void { _urlimg = value; }
		
		
	}

}