package ascode
{
	import data2.asxml.ASCode;
	import data2.fx.delay.DelayManager;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import view.ViewCollection;
	import view.ViewGameMemory;
	import view.ViewHeader;
	
	/**
	 * ...
	 * @author Vinc
	 */
	public class ASCodeGameMemory extends ASCode
	{
		private var _lastIndexImg:int;
		private var _lastIndexCard:int;
		private var _tabIndexValid:Array;
		private var _lockAction:Boolean = true;
		
		public function ASCodeGameMemory()
		{
		
		}
		
		override public function exec():void
		{
			
		}
		
		public function initScreen():void
		{
			trace("ASCodeGameMemory.initScreen()");
			ViewGameMemory.init();
			initGame();
			
			ViewHeader.updateHeader(0xdab8ca, false);
			//ViewGameMemory.setFooter("restart");
			
		}
		
		
		public function initGame():void
		{
			_lastIndexImg = -1;
			ViewGameMemory.initGame();
			_tabIndexValid = [];
			ViewGameMemory.setFooter("help");
			_lockAction = false;
		}
		
		
		
		
		
		
		
		
		//______________________________________________________________________
		//events
		
		
		public function onclickCard(_index:int):void
		{
			trace("onclickCard(" + _index + ")");
			if (_lastIndexImg != -1 && _index == _lastIndexCard) {
				trace("can't play 2 times same");
				return;
			}
			if (_tabIndexValid.indexOf(_index) != -1) {
				trace("already discovered");
				return;
			}
			if (_lockAction) return;
			
			_lockAction = true;
			
			
			ViewGameMemory.flipCard(_index);
			
			var _indeximg:int = ViewGameMemory.getIndexImgAt(_index);
			trace("_indeximg : " + _indeximg);
			
			
			if (_lastIndexImg == -1) {
				_lastIndexImg = _indeximg;
				_lockAction = false;
			}
			else {
				//success
				if (_lastIndexImg == _indeximg) {
					_tabIndexValid.push(_lastIndexCard);
					_tabIndexValid.push(_index);
					
					
					
					DelayManager.add("", 700, showValids, [_lastIndexCard, _index], true);
					
					DelayManager.add("", 700, function():void {
						
						if (_tabIndexValid.length == 12) {
							//finish, footer
							ViewGameMemory.setFooter("restart");
						}
						else {
							_lockAction = false;
						}
					});
				}
				//error
				else {
					
					DelayManager.add("", 1000, flipCards, [_lastIndexCard, _index]);
					DelayManager.add("", 1750, function():void
					{
						_lockAction = false;
					});
					
				}
				
				
				_lastIndexImg = -1;
			}
			
			_lastIndexCard = _index;
			
		}
		
		
		private function flipCards(_tab:Array):void
		{
			for (var i:int = 0; i < _tab.length; i++) ViewGameMemory.flipCard(_tab[i]);
		}
		
		private function showValids(_tab:Array, _value:Boolean):void
		{
			for (var i:int = 0; i < _tab.length; i++) ViewGameMemory.showValid(_tab[i], _value);
		}
		
		
		
		public function clickRestart():void
		{
			ViewGameMemory.flipAll();
			ViewGameMemory.showValidAll(false);
			
			
			DelayManager.add("", 2000, function():void {	
				initGame();
			});
		}
		
		
	
	}

}