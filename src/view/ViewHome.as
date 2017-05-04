package view 
{
	import data2.mvc.ViewBase;
	import flash.display.Sprite;
	import utils.VideoBox;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ViewHome extends ViewBase
	{
		static private var _video:VideoBox;
		
		public function ViewHome() 
		{
			
		}
		
		public static function selectLang(_lang:String):void
		{
			for (var i:int = 0; i < DataGlobal.LIST_LANG.length; i++) 
			{
				var _l:String = DataGlobal.LIST_LANG[i];
				getSprite("btn_" + _l).alpha = 0.4;
			}
			if (_lang != "") getSprite("btn_" + _lang).alpha = 1.0;
			
		}
		
		
		
		
		
		
		
		
		
		static public function initVideo():void 
		{
			trace("ViewHome.initVideo");
			var _container:Sprite = getSprite("video_container_sub");
			_video = new VideoBox();
			_container.addChild(_video);
			_video.loop = true;
			_video.load("videos/veille.mp4");
			_video.visible = DataGlobal.DISPLAY_VIDEO;
			//_video.play();
		}
		
		
		
		
		public static function resetPositionVideo():void
		{
			_video.position = 0;
		}
		
		
		public static function playVideo(_value:Boolean):void 
		{
			if (_value) _video.resume();
			else _video.pause();
			
			//_video.visible = _value;
		}
		
		
		
	}

}