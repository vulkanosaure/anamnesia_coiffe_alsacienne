package assets.memory
{
	import data.fx.transitions.TweenManager;
	import data2.fx.delay.DelayManager;
	import data2.InterfaceSprite
	import data2.mvc.Component;
	import data2.text.Text
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	
	public class Component_memory_item extends InterfaceSprite
	{
		private const SIZE:Point = new Point(282, 280);
		private const IMG_SIZE:Point = new Point(134, 218);
		
		private var _is98:Sprite;
		private var _twm:TweenManager = new TweenManager();
		
		private var _img:DisplayObject;
		private var _indeximg:int;
		
		private var _containerImg:Sprite;
		private var _cardBack:Sprite;
		private var _container:Sprite;
		private var _isBack:Boolean;
		
		private const DEBUG_ROTATION_Y:Boolean = false;
		
		public function Component_memory_item()
		{
			initComponent();
		}
		
		
		public function initComponent():void 
		{
			_container = new Sprite();
			_container.x = SIZE.x / 2;
			_container.y = SIZE.y / 2;
			
			
			var _is0:Sprite = new asset_memory_item_bg();
			this.addChild(_is0);
			_is0.x = 7; _is0.y = 7; 
			
			
			this.addChild(_container);
			
			
			_cardBack = new asset_memory_item_fg();
			_container.addChild(_cardBack);
			_cardBack.x = -SIZE.x / 2; _cardBack.y = -SIZE.y / 2;
			
			_containerImg = new asset_memory_item_img();
			_container.addChild(_containerImg);
			_containerImg.x = -SIZE.x / 2; _containerImg.y = -SIZE.y / 2;
			
			_is98 = new asset_memory_item_valid();
			this.addChild(_is98);
			_is98.x = 124; _is98.y = 255; 
			
			this.transform.perspectiveProjection = new PerspectiveProjection();
			this.transform.perspectiveProjection.projectionCenter = new Point(SIZE.x / 2, SIZE.y / 2);
			
			
		}
		
		
		public function updateComponent():void
		{
			if (!DEBUG_ROTATION_Y) _container.rotationY = 0;
			
			_containerImg.addChild(_img);
			_img.scaleX = -1;
			_img.x = Math.round(SIZE.x * 0.5 + IMG_SIZE.x * 0.5);
			//_img.x = Math.round(SIZE.x * 0.5 - IMG_SIZE.x * 0.5);
			_img.y = Math.round(SIZE.y * 0.5 - IMG_SIZE.y * 0.5);
			
			
			
		}
		
		public function setState(_back:Boolean):void
		{
			_cardBack.visible = _back;
			_containerImg.visible = !_back;
			_isBack = _back;
		}
		
		
		
		
		public function flip(_back:Boolean):void
		{
			_isBack = _back;
			
			var _time:Number = 0.7;
			
			_cardBack.visible = !_back;
			_containerImg.visible = _back;
			
			if (!DEBUG_ROTATION_Y) {
				var _currota:Number = _container.rotationY;
				_twm.tween(_container, "rotationY", _currota, _currota + 180, _time, 0);
			}
			
			
			DelayManager.add("", _time * 1000 * 0.31, function():void
			{
				_cardBack.visible = _back;
				_containerImg.visible = !_back;
				
			});
			
		}
		
		
		
		
		public function showValid(_value:Boolean):void
		{
			_is98.visible = _value;
		}
		
		public function set img(value:DisplayObject):void 
		{
			_img = value;
		}
		
		public function get isBack():Boolean 
		{
			return _isBack;
		}
		
		public function get indeximg():int 
		{
			return _indeximg;
		}
		
		public function set indeximg(value:int):void 
		{
			_indeximg = value;
		}
		
	}
	
}

