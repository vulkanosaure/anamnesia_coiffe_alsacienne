package assets.collection 
{
	import adobe.utils.ProductManager;
	import data.display.FilledRectangle;
	import data2.asxml.ObjectSearch;
	import data2.mvc.Component;
	import data2.net.imageloader.ImageLoader;
	import events.BroadCaster;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Vinc
	 */
	public class Component_image_collection_big extends Component
	{
		private var _isZoomed:Boolean;
		var _containerImg:Sprite;
		public var isInit = false;
		private var _helpvisible:Boolean;
		private var _rect:FilledRectangle;
		
		private var _loader2:Loader;
		private var _bmp2:Bitmap;
		private var _bmpd2:BitmapData;
		private var _urlimgbig:String;
		
		public function Component_image_collection_big() 
		{
			
		}
		
		
		override public function initComponent():void 
		{
			super.initComponent();
			
			
			_rect = new FilledRectangle(0x009900);
			_rect.alpha = 0.0;
			_rect.width = 1080;
			_rect.height = 972;
			this.addChild(_rect);
			
			
			_bmp = new Bitmap();
			
			_containerImg = new Sprite();
			this.addChild(_containerImg);
			_containerImg.addChild(_bmp);
			
			
			
			_bmp2 = new Bitmap();
			_containerImg.addChild(_bmp2);
			_bmp2.smoothing = true;
			
			_loader2 = new Loader();
			_loader2.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete2);
			
			
			
			_containerImg.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);		//todo stage
			
			isInit = true;
			
			_containerImg.doubleClickEnabled = true;
			_containerImg.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
		}
		
		
		
		
		
		override public function updateComponent(_value:Boolean = true):void
		{
			
			if (_loader2 == null) throw new Error("initComponent has not been called");
			var _img2:DisplayObject = ImageLoader.getImage(_urlimgbig);
			
			if (_img2 != null) {
				
				var _bmpimg2:Bitmap = Bitmap(_img2);
				_bmpd2 = _bmpimg2.bitmapData;
				_bmp2.bitmapData = _bmpd2;
				
				trace("updateComponent :: already loaded : " + _urlimgbig);
			}
			else {
				trace("updateComponent :: must load : " + _urlimgbig);
				ImageLoader.add(_loader2, _urlimgbig);
			}
			
			
			super.updateComponent(_value);
			
			
		}
		
		
		public function set urlimgbig(value:String):void { _urlimgbig = value; }
		
		
		private function onLoaderComplete2(e:Event):void 
		{
			var _loader:Loader = LoaderInfo(e.target).loader;
			_bmpd2 = (_loader.content as Bitmap).bitmapData;
			_bmp2.bitmapData = _bmpd2;
			
		}
		
		
		private function onDoubleClick(e:MouseEvent):void 
		{
			BroadCaster.dispatchEvent(new Event("DOUBLE_CLICK_COLLECTION"));
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			trace("onMouseUp");
			
			
			_containerImg.stopDrag();
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			if (!_isZoomed) return;
			trace("onMouseDown");
			if (_helpvisible) {
				var _helpdrag:Sprite = Sprite(ObjectSearch.getID("asset_icon_helpdrag"));
				_helpdrag.visible = false;
				_helpvisible = false;
			}
			
			/*
			var _bounds:Rectangle = new Rectangle();
			_bounds.x = -250;
			_bounds.y = -550;
			_bounds.width = 280;
			_bounds.height = 500;
			*/
			
			/*
			var img:Rectangle = new Rectangle(0, 0, 1905, 1868);
			var rect:Rectangle = new Rectangle(-1200, -1250, 1280, _rect.height);
			
			var _bounds:Rectangle = new Rectangle();
			_bounds.x = rect.x + (img.width * .5) - (rect.width * .5);  //offset by + half of the image, and - half of the rectangle
			_bounds.y = rect.y + (img.height * .5) - (rect.height * .5);
			_bounds.width = Math.abs(rect.width - img.width); //make the bounds the size of the rectangle, minus the size of the image
			_bounds.height = Math.abs(rect.height - img.height);
			*/
			
			var _bounds:Rectangle = new Rectangle(10, 20, -728, -706);
			//diminuer dans le négatif (ex : -800 => -700 rapeticit la zone)
			
			_containerImg.startDrag(false, _bounds);
		}
		
		
		
		
		public function setScale(_big:Boolean):void
		{
			_isZoomed = _big;
			
			//var _scalesmall:Number = 0.32;
			var _scalesmall:Number = 1;
			var _scale:Number = (_isZoomed) ? 1 : _scalesmall;
			_bmp.scaleX = _bmp.scaleY = _scale;
			
			
			var _imgdim:Point = new Point(1905, 1868);
			var _imgdimsmall:Point = new Point(610, 598);
			
			var _possmall:Point = new Point();
			_possmall.x = 1080 * 0.5 - _imgdimsmall.x * 0.5;
			_possmall.y = 972 * 0.5 - _imgdimsmall.y * 0.5;
			
			var _posbig:Point = new Point();
			_posbig.x = 1080 * 0.5 - _imgdim.x * 0.5;
			_posbig.y = 972 * 0.5 - _imgdim.y * 0.5;
			
			var _position:Point = (_isZoomed) ? _posbig : _possmall;
			_containerImg.x = _position.x;
			_containerImg.y = _position.y;
			
			var _helpdrag:Sprite = Sprite(ObjectSearch.getID("asset_icon_helpdrag"));
			_helpdrag.visible = _isZoomed;
			_helpvisible = _isZoomed;
			
			_bmp.visible = !_big;
			_bmp2.visible = _big;
			
		}
		
		
		
	}

}