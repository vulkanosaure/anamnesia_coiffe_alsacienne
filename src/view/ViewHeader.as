package view 
{
	import assets.Component_header;
	import data2.asxml.ObjectSearch;
	import data2.mvc.ViewBase;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ViewHeader extends ViewBase
	{
		
		public function ViewHeader() 
		{
			
		}
		
		
		
		public static function initLang(_tablang:Array):void
		{
			for (var i:int = 0; i < 3; i++) 
			{
				var _langtest:String = DataGlobal.LIST_LANG[i];
				var _visible:Boolean = (_tablang.indexOf(_langtest) != -1);
				var _id:String = "btn_" + _langtest + "2";
				var _is:Sprite = Sprite(ObjectSearch.getID(_id));
				
				if (_tablang.length < 2) _visible = false;
				_is.visible = _visible;
				
			}
		}
		
		
		
		public static function updateHeader(_bgcolor:uint, _typevisible:Boolean):void
		{
			var _header:Component_header = Component_header(ObjectSearch.getID("component_header"));
			_header.bgcolor = _bgcolor;
			_header.typevisible = _typevisible;
			_header.update();
			
		}
		
		
		
		static public function updateFilter(_listEnabled:Array):void 
		{
			var _header:Component_header = Component_header(ObjectSearch.getID("component_header"));
			var _listFilters:Array = _header.getFilters();
			
			for (var i:int = 0; i < _listFilters.length; i++) 
			{
				var _filter:Sprite = Sprite(_listFilters[i]);
				
				var _enabled:Boolean = (_listEnabled.indexOf((i + 1)) != -1);
				setFilterEnabled(_filter, _enabled);
			}
			
		}
		
		static private function setFilterEnabled(_item:Sprite, _value:Boolean):void 
		{
			_item.alpha = (_value) ? 1.0 : 0.6;
		}
		
		static public function selectLang(_lang:String):void
		{
			for (var i:int = 0; i < DataGlobal.LIST_LANG.length; i++) 
			{
				var _l:String = DataGlobal.LIST_LANG[i];
				var _btn:Sprite = getSprite("btn_" + _l + "2");
				_btn.alpha = (_l == _lang) ? 1.0 : 0.4;
			}
		}
		
		
	}

}