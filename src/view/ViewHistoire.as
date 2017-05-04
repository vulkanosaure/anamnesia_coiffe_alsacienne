package view 
{
	import assets.histoire.Component_histoire_menuitem;
	import assets.histoire.Component_histoire_text;
	import assets.histoire.Component_scrollbar_handle;
	import data2.display.scrollbar.Scrollbar;
	import data2.mvc.ViewBase;
	import data2.net.imageloader.ImageLoader;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ViewHistoire extends ViewBase
	{
		static public const MENU_DELTAX:int = 259;
		private static var _itemsmenu_histoire:Array;
		private static var _itemsmenu_territoire:Array;
		static private var _deltax:Number = 1390;
		
		
		public function ViewHistoire() 
		{
			
		}
		
		
		public static function initMenu(_section:String, _len:int):void
		{
			trace("ViewHistoire.initMenu(" + _len + ")");
			
			var _itemsmenu:Array;
			if (_section == "histoire") {
				_itemsmenu_histoire = new Array();
				_itemsmenu = _itemsmenu_histoire;
			}
			else {
				_itemsmenu_territoire = new Array();
				_itemsmenu = _itemsmenu_territoire;
			}
			
			var _container:Sprite = getSprite("menu_" + _section + "_list");
			
			for (var i:int = 0; i < _len; i++) 
			{
				var _item:Component_histoire_menuitem = new Component_histoire_menuitem();
				_container.addChild(_item);
				_item.x = i * MENU_DELTAX;
				_item.index = i;
				_item.section = _section;
				_item.initComponent();
				_item.setSelected(i == 0);
				_itemsmenu.push(_item);
				_item.clickableMargin_vert = 30;
				_item.clickableMargin_left = 12;
				_item.onmousedown = "as:#ascode" + _section + "  onClickMenu  " + i;
				
				_item.initOnClick(0);
				
			}
			
			
			
		}
		
		public static function initContent(_section:String, _tab:Array):void
		{
			var _container:Sprite = getSprite(_section + "_content_scrollable_sub");
			for (var i:int = 0; i < _tab.length; i++) 
			{
				var _item:Component_histoire_text = new Component_histoire_text();
				_item.index = i;
				_item.section = _section;
				_item.initComponent();
				_container.addChild(_item);
				_item.x = i * _deltax;
				_item.urlimg = _tab[i].img;
				_item.updateComponent();
				
				
			}
			
			
			var _widthcontent:Number = _tab.length * _deltax;
			_container.rotation = -90;
			_container.y = _widthcontent;
			
			var _scrollbar:Scrollbar = getScrollbar("scroll_" + _section);
			_scrollbar.rotation = 90;
			_scrollbar.x = 1080 - 40;
			
			var _handle:Sprite = Sprite(_scrollbar.getChildByName("mcHandle"));
			var _componentTextHandle:Component_scrollbar_handle = new Component_scrollbar_handle();
			_componentTextHandle.initComponent(_section);
			_handle.addChild(_componentTextHandle);
			_componentTextHandle.x = 11; _componentTextHandle.y = 172;
			_componentTextHandle.rotation = -90;
			
			
			gotoPart(_section, 0);
			
			
			ImageLoader.loadGroup();
			
		}
		
		public static function updateScrollbar(_section:String):void
		{
			var _scrollbar:Scrollbar = getScrollbar("scroll_" + _section);
			_scrollbar.update();
		}
		
		
		public static function selectMenu(_section:String, _index:int):void
		{
			var _itemsmenu:Array = (_section == "histoire") ? _itemsmenu_histoire : _itemsmenu_territoire;
			for (var i:int = 0; i < _itemsmenu.length; i++) 
			{
				var _item:Component_histoire_menuitem = Component_histoire_menuitem(_itemsmenu[i]);
				_item.setSelected(_index == i);
				
			}
		}
		
		public static function gotoPart(_section:String, _index:int):void
		{
			var _scrollbar:Scrollbar = getScrollbar("scroll_" + _section);
			
			var _itemsmenu:Array = (_section == "histoire") ? _itemsmenu_histoire : _itemsmenu_territoire;
			var _nbpart:int = _itemsmenu.length;
			
			var _contentheight:Number = _nbpart * _deltax;
			var _lenmovemc:Number = _contentheight - 1040;
			
			var _dist:Number = Math.round(_lenmovemc - _index * _deltax);
			
			var _lenscroll:Number = 1040 - 208;
			
			var _px:Number = _dist * _lenscroll / _lenmovemc;
			trace("_px : " + _px);
			
			//_scrollbar.scrollToPx(_px);
			_twm.tween(_scrollbar, "scrollPx", NaN, _px, 0.4);
			
		}
		
		
	}

}