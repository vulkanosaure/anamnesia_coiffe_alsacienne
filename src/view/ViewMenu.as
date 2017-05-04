package view 
{
	import assets.menu.Component_diapoMenu;
	import data2.mvc.ViewBase;
	import flash.display.Sprite;
	import model.ModelMenu;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ViewMenu extends ViewBase
	{
		static private var _diapo:Component_diapoMenu;
		
		public function ViewMenu() 
		{
			
		}
		
		public static function initDiapo():void
		{
			var _container:Sprite = getSprite("btn_incontournables_diapo");
			_diapo = new Component_diapoMenu();
			_diapo.listurl = ModelMenu.getImageDiapo();
			
			_diapo.initComponent();
			_container.addChild(_diapo);
		}
		
		public static function playDiapo(_value:Boolean):void
		{
			if (_value) _diapo.play();
			else _diapo.pause();
			
		}
		
	}

}