package assets.collection 
{
	import data2.InterfaceSprite;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vinc
	 */
	public class Component_collection_pagination_item extends InterfaceSprite
	{
		private var _itemon:Sprite;
		private var _itemoff:Sprite;
		
		public function Component_collection_pagination_item() 
		{
			_itemon = new asset_pagination_on();
			this.addChild(_itemon);
			
			_itemoff = new asset_pagination_off();
			this.addChild(_itemoff);
			
			_itemoff.x = -5; _itemoff.y = -5;
			_itemon.x = -5; _itemon.y = -5;
		}
		
		public function setSelected(_value:Boolean):void
		{
			_itemon.visible = _value;
			_itemoff.visible = !_value;
		}
		
	}

}