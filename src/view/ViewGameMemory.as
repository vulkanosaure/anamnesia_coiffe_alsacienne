package view 
{
	import assets.memory.Component_memory_item;
	import data2.dynamiclist.DynamicList;
	import data2.fx.delay.DelayManager;
	import data2.math.Math2;
	import data2.mvc.ViewBase;
	import data2.text.Text;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ViewGameMemory extends ViewBase
	{
		private static const NB_CARDS:int = 12;
		private static var _listImg:Array;
		private static var _items:Array;
		
		public function ViewGameMemory() 
		{
			
		}
		
		static public function init():void 
		{
			if (_listImg == null) {
				_listImg = new Array();
				for (var j:int = 0; j < NB_CARDS; j++) 
				{
					var _index:int = Math.floor(j / 2);
					var _class:Class = getDefinitionByName("Memory_img" + _index) as Class;
					var _dobj:DisplayObject = new _class() as DisplayObject;
					_listImg.push([_dobj, _index]);
					
				}
				
				var _delta:Point = new Point(326, 324);
				var _container:Sprite = getSprite("memory_container_game");
				_items = new Array();
				
				for (var i:int = 0; i < NB_CARDS; i++) 
				{
					var _item:Component_memory_item = new Component_memory_item();
					_container.addChild(_item);
					_item.x = (i % 3) * _delta.x;
					_item.y = Math.floor(i / 3) * _delta.y;
					_item.onmousedown = "as:#ascodegamememory  onclickCard  " + i;
					_item.initOnClick(0);
					_items.push(_item);
					
				}
				
			}
		}
		
		
		static public function initGame():void
		{
			var _tab:Array = DynamicList.shuffleArray(_listImg);
			
			for (var i:int = 0; i < NB_CARDS; i++) 
			{
				var _item:Component_memory_item = Component_memory_item(_items[i]);
				_item.showValid(false);
				_item.img = DisplayObject(_tab[i][0]);
				_item.indeximg = _tab[i][1];
				_item.updateComponent();
				
				_item.setState(true);
			}
			
			
		}
		
		
		static public function flipCard(_index:int):void 
		{
			var _item:Component_memory_item = Component_memory_item(_items[_index]);
			_item.flip(!_item.isBack);
		}
		
		static public function getIndexImgAt(_indexpos:int):int
		{
			 var _item:Component_memory_item = Component_memory_item(_items[_indexpos]);
			 return _item.indeximg;
		}
		
		static public function showValid(_index:int, _value:Boolean):void 
		{
			var _item:Component_memory_item = Component_memory_item(_items[_index]);
			_item.showValid(_value);
		}
		
		//restart,help
		static public function setFooter(_type:String):void 
		{
			var _help:Sprite = getSprite("memory_footer");
			var _btnrestart:Sprite = getSprite("btn_restart_memory");
			_help.visible = (_type == "help");
			_btnrestart.visible = (_type == "restart");
		}
		
		static public function flipAll():void 
		{
			for (var i:int = 0; i < NB_CARDS; i++) 
			{
				DelayManager.add("", i * 100, flipCard, i);
			}
		}
		
		static public function showValidAll(boolean:Boolean):void 
		{
			for (var i:int = 0; i < NB_CARDS; i++) showValid(i, boolean);
		}
		
		static public function onFooterResize(_text:Text):void 
		{
			trace("ViewGameMemory.onFooterResize");
			var _asset:Sprite = getSprite("asset_memory_footer");
			_asset.x = 1080 * 0.5 - _text.getTextBounds().width * 0.5 - 85;
			_text.x = 1080 * 0.5 - _text.getTextBounds().width * 0.5;
			
		}
		
		static public function onBtnRestartResize(_text:Text):void 
		{
			var _asset:Sprite = getSprite("asset_restart_memory");
			_asset.x = 1080 * 0.5 - _text.getTextBounds().width * 0.5 - 85;
			_text.x = 1080 * 0.5 - _text.getTextBounds().width * 0.5;
			
		}
		
	}

}