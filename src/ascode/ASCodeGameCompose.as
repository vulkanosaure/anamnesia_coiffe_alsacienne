package ascode 
{
	import data2.asxml.ASCode;
	import view.ViewGameCompose;
	import view.ViewHeader;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ASCodeGameCompose extends ASCode
	{
		private var _curstep:int;
		
		public function ASCodeGameCompose() 
		{
			
		}
		
		
		override public function exec():void 
		{
			ViewGameCompose.init_real();
			
		}
		
		public function initScreen():void 
		{
			
			ViewHeader.updateHeader(0x6ab3bf, false);
			ViewGameCompose.init();
			
			
			ViewGameCompose.setBtnEnabled("btn_gamecompose_start", true);
			ViewGameCompose.setBtnEnabled("btn_gamecompose_replay", false);
			
		}
		
		
		public function onClickStart():void
		{
			trace("ASCodeGameCompose.onClickStart");
			ViewGameCompose.gotoSteps();
			
			_curstep = 0;
			ViewGameCompose.updatePagination(_curstep);
			ViewGameCompose.updateStep(_curstep, true);
			ViewGameCompose.setSelected(0);
			
			ViewGameCompose.setBtnEnabled("btn_gamecompose_start", false);
			ViewGameCompose.setBtnEnabled("btn_gamecompose_replay", true);
		}
		
		public function onClickReplay():void
		{
			ViewGameCompose.gotoStart();
			
			ViewGameCompose.setBtnEnabled("btn_gamecompose_start", true);
			ViewGameCompose.setBtnEnabled("btn_gamecompose_replay", false);
		}
		
		
		
		public function onClickNavig(_delta:int):void
		{
			trace("ASCodeGameCompose.onClickNavig(" + _delta + ")");
			
			_curstep += _delta;
			ViewGameCompose.updatePagination(_curstep);
			ViewGameCompose.navigateStep(_curstep, _delta);
			
			
			
		}
		
		public function onClickBtnChoice(_index:int):void
		{
			trace("ASCodeGameCompose.onClickBtnChoice(" + _index + ")");
			ViewGameCompose.clickChoice(_index);
			
		}
		
	}

}