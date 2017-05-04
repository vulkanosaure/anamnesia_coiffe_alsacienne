package ascode 
{
	import data2.asxml.ASCode;
	import data2.asxml.Constantes;
	import data2.fx.delay.DelayManager;
	import view.ViewHeader;
	import view.ViewHistoire;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ASCodeTerritoire extends ASCode
	{
		private const SECTION:String = "territoire";
		private var _data:Array;
		
		public function ASCodeTerritoire() 
		{
			
		}
		
		override public function exec():void 
		{
			super.exec();
			
			_data = Constantes.get("fr.territoire.content.item") as Array;
			ViewHistoire.initMenu(SECTION, _data.length);
			ViewHistoire.initContent(SECTION, _data);
			
			
		}
		
		public function initScreen():void 
		{
			ViewHistoire.selectMenu(SECTION, 0);
			ViewHistoire.updateScrollbar(SECTION);
			
			ViewHeader.updateHeader(0xd09c52, false);
			
		}
		
		public function onClickMenu(_index:int):void
		{
			ViewHistoire.selectMenu(SECTION, _index);
			ViewHistoire.gotoPart(SECTION, _index);
			
		}
	}

}