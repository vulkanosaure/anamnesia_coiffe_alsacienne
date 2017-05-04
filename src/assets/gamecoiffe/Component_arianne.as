package assets.gamecoiffe 
{
	import data2.InterfaceSprite;
	/**
	 * ...
	 * @author Vinc
	 */
	public class Component_arianne extends InterfaceSprite
	{
		private var _items:Array;
		private var _length:int;
		private var _curindex:int;
		
		public function Component_arianne() 
		{
			
		}
		
		public function initComponent():void
		{
			_items = new Array();
			for (var i:int = 0; i < _length; i++) 
			{
				var _item:Component_question_arianne = new Component_question_arianne();
				this.addChild(_item);
				_items.push(_item);
				_item.x = i * 37;
			}
			
		}
		
		public function set length(value:int):void 
		{
			_length = value;
		}
		
		
		public function reset():void
		{
			for (var i:int = 0; i < _length; i++) 
			{
				var _item:Component_question_arianne = Component_question_arianne(_items[i]);
				var _state:String;
				if (i == 0) _state = Component_question_arianne.DONE;
				else _state = Component_question_arianne.UNDONE;
				_item.setState(_state);
			}
			_curindex = 0;
		}
		
		public function add(_correct:Boolean):void 
		{
			var _item:Component_question_arianne = Component_question_arianne(_items[_curindex]);
			_item.setState(_correct ? Component_question_arianne.VALID : Component_question_arianne.WRONG);
			
			_curindex++;
			if (_curindex < _length) {
				_item = Component_question_arianne(_items[_curindex]);
				_item.setState(Component_question_arianne.DONE);
			}
			
		}
		
		
		
	}

}