package data2.navigation 
{
	/**
	 * ...
	 * @author Vinc
	 */
	public class NavigationDef 
	{
		public static const DOWN:String = "down";
		public static const TOP:String = "top";
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const NONE:String = "none";
		public static const ZOOM:String = "zoom";
		
		private var _id:String;
		private var _value:Boolean;
		private var _side:String;
		private var _delay:Number;
		private var _dist:Number;
		private var _fade:Boolean;
		
		
		public function NavigationDef(__id:String, __side:String, __delay:Number, __dist:Number = 1100, __fade:Boolean = false) 
		{
			_id = __id;
			_side = __side;
			_delay = __delay;
			_dist = __dist;
			_fade = __fade;
			
		}
		
		
		
		
		
		public function get id():String 
		{
			return _id;
		}
		
		public function get value():Boolean 
		{
			return _value;
		}
		
		public function get side():String 
		{
			return _side;
		}
		
		public function get delay():Number 
		{
			return _delay;
		}
		
		public function get dist():Number 
		{
			return _dist;
		}
		
		public function set value(_v:Boolean):void 
		{
			_value = _v;
		}
		
		public function get fade():Boolean 
		{
			return _fade;
		}
		
	}

}