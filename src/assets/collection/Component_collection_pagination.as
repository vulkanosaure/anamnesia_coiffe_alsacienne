package assets.collection 
{
	import data2.InterfaceSprite;
	/**
	 * ...
	 * @author Vinc
	 */
	public class Component_collection_pagination extends InterfaceSprite
	{
		private const MAX_NBPAGE:int = 20;
		public static const DELTAX:Number = 22;
		
		private var _nbitem:int;
		private var _items:Array;
		
		public function Component_collection_pagination() 
		{
			
		}
		
		public function initComponent():void
		{
			_items = new Array();
			for (var i:int = 0; i < MAX_NBPAGE; i++) 
			{
				var _item:Component_collection_pagination_item = new Component_collection_pagination_item();
				this.addChild(_item);
				_item.x = i * DELTAX;
				_items.push(_item);
			}
		}
		
		public function updateComponent():void
		{
			for (var i:int = 0; i < MAX_NBPAGE; i++) 
			{
				var _item:Component_collection_pagination_item = Component_collection_pagination_item(_items[i]);
				_item.visible = (i < _nbitem);
			}
		}
		
		
		public function select(_index:int):void
		{
			for (var i:int = 0; i < MAX_NBPAGE; i++) 
			{
				var _item:Component_collection_pagination_item = Component_collection_pagination_item(_items[i]);
				_item.setSelected(_index == i);
			}
		}
		
		
		public function set nbitem(value:int):void 
		{
			_nbitem = value;
		}
		
	}

}