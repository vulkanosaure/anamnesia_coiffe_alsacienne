package data2.net.imageloader 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class ImageLoaderEvent extends Event 
	{
		public static const PROGRESS:String = "ImageLoaderEvent_PROGRESS";
		public static const COMPLETE:String = "ImageLoaderEvent_COMPLETE";
		public static const IMG_COMPLETE:String = "ImageLoaderEvent_IMG_COMPLETE";
		
		public var group:String;
		public var progress:Number;
		public var src:String;
		public var content:DisplayObject;
		
		
		public function ImageLoaderEvent(type:String, _group:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			group = _group;
		} 
		
		public override function clone():Event 
		{ 
			return new ImageLoaderEvent(type, group, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ImageLoaderEvent", "type", "group", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}