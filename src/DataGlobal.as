package  
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Vinc
	 */
	public class DataGlobal 
	{
		public static var lang:String;
		static public var videomc:MovieClip;
		
		public function DataGlobal() 
		{
			
		}
		
		public static const LIST_LANG:Array = ["fr", "en", "de"];
		
		public static const NB_FILTERS:int = 2;
		static public const NB_ARTICLE_PER_PAGE:int = 12;
		
		static public const NB_PART_HISTOIRE:int = 3;
		static public const NB_PART_TERRITOIRE:int = 3;
		
		static public const DEBUG_MODE:Boolean = false;
		static public const DEBUG_NAVIGATION:Boolean = false;
		static public const DEBUG_CLICKABLE:Boolean = false;
		static public const DISPLAY_VIDEO:Boolean = true;
		
	}

}