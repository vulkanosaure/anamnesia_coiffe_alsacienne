package ascode
{
	import data2.asxml.ASCode;
	import data2.asxml.Constantes;
	import data2.asxml.ObjectSearch;
	import data2.fx.delay.DelayManager;
	import data2.navigation.Navigation;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import model.translation.Translation;
	import timertouch.TimerTouch;
	import timertouch.TimerTouchEvent;
	import view.ViewHeader;
	import view.ViewHome;
	
	/**
	 * ...
	 * @author Vinc
	 */
	public class ASCodeHome extends ASCode
	{
		private var _homelang:String;
		
		
		
		
		public function ASCodeHome()
		{
		
		}
		
		override public function exec():void
		{
			ViewHome.initVideo();
			
			
			TimerTouch.init(Number(Constantes.get("config.delay_iddle")), _stage);
			TimerTouch.addEventListener(TimerTouchEvent.NO_TOUCH, onTimerIddle);
			TimerTouch.addEventListener(TimerTouchEvent.WAKE_UP, onTimerWakeUp);
			
			
			var _delay:Number = Number(Constantes.get("config.delay_anim_home")) * 1000;
			trace("_delay : " + _delay);
			var _timerHomeLang:Timer = new Timer(_delay);
			_homelang = "fr";
			_timerHomeLang.addEventListener(TimerEvent.TIMER, onTimerHomeLang);
			_timerHomeLang.start();
			
			Navigation.addCallback("screen_home", Navigation.CALLBACK_GOTO, onGotoHome);
			
			var _strlang:String = String(Constantes.get("config.langs"));
			var _tablang:Array = _strlang.split(",");
			for (var i:int = 0; i < 3; i++) 
			{
				var _langtest:String = DataGlobal.LIST_LANG[i];
				var _visible:Boolean = (_tablang.indexOf(_langtest) != -1);
				var _id:String = "btn_" + _langtest;
				var _is:Sprite = Sprite(ObjectSearch.getID(_id));
				
				if (_tablang.length < 2) _visible = false;
				_is.visible = _visible;
				
			}
			
			if (_tablang.length < 2) _stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpStage);
			ViewHeader.initLang(_tablang);
		}
		
		
		
		private function onMouseUpStage(e:MouseEvent):void 
		{
			//_stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpStage);
			//trace("onMouseUpStage " + Navigation.curscreen);
			if (Navigation.curscreen != "screen_home") return;
			
			onClickLang(DataGlobal.LIST_LANG[0]);
			
		}
		
		
		private function onGotoHome():void 
		{
			trace("onGotoHome");
			ViewHome.selectLang("");
		}
		
		
		
		
		public function onClickLang(_lang:String):void
		{
			ViewHome.selectLang(_lang);
			
			DelayManager.add("", 600, function():void {
				Translation.translate(_lang);
			
				ViewHeader.selectLang(_lang);
				Navigation.gotoScreen("screen_menu");
			});
			
			DelayManager.add("", 1500, ViewHome.playVideo, false);
			
		}
		
		
		
		
		public function onClickLangHeader(_lang:String):void 
		{
			trace("ASCodeHome.onClickLangHeader " + _lang);
			Translation.translate(_lang);
			ViewHeader.selectLang(_lang);
			
		}
		
		public function onClickCredits():void
		{
			Navigation.gotoScreen("screen_credits");
		}
		
		public function onCloseCredits():void
		{
			Navigation.gotoPrevScreen();
		}
		
		
		
		private function onTimerHomeLang(e:TimerEvent):void 
		{
			//trace("onTimerHomeLang " + Navigation.curscreen);
			if (Navigation.curscreen != "screen_home") return;
			
			var _indexof:int = DataGlobal.LIST_LANG.indexOf(_homelang);
			_indexof++;
			if (_indexof >= DataGlobal.LIST_LANG.length) _indexof = 0;
			_homelang = DataGlobal.LIST_LANG[_indexof];
			
			Translation.translate(_homelang, ["home_title", "home_subtitle"]);
			
		}
		
		
		
		
		
		private function onTimerWakeUp(e:TimerTouchEvent):void 
		{
			trace("ASCodeHome.onTimerWakeUp");
			
		}
		
		private function onTimerIddle(e:TimerTouchEvent):void 
		{
			trace("ASCodeHome.onTimerIddle");
			
			if (Navigation.curscreen != "screen_home") {
				
				Navigation.gotoScreen("screen_home");
				
				ViewHome.resetPositionVideo();
				ViewHome.playVideo(true);
				
			}
			
		}
		
		
	}

}