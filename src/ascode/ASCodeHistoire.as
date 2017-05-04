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
	public class ASCodeHistoire extends ASCode
	{
		private const SECTION:String = "histoire";
		private var _data:Array;
		
		public function ASCodeHistoire() 
		{
			
		}
		
		override public function exec():void 
		{
			super.exec();
			
			_data = Constantes.get("fr.histoire.content.item") as Array;
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
			trace("ASCodeHistoire.onClickMenu(" + _index + ")");
			ViewHistoire.selectMenu(SECTION, _index);
			ViewHistoire.gotoPart(SECTION, _index);
			
		}
	}

}