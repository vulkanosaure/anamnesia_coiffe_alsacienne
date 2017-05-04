package model 
{
	import data2.asxml.Constantes;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ModelMenu 
	{
		
		public function ModelMenu() 
		{
			
		}
		
		public static function getImageDiapo():Array
		{
			var _tab:Array = Constantes.get("diapo_menu.item") as Array;
			trace("diapo_tab : " + _tab);
			return _tab;
		}
		
		
	}

}