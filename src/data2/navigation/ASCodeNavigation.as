package data2.navigation 
{
	import assets.LabelYear;
	import assets.LayoutCounter;
	import data.fx.transitions.TweenManager;
	import data2.asxml.ASCode;
	import data2.asxml.ObjectSearch;
	import data2.behaviours.layout.GridLayout;
	import data2.fx.delay.DelayManager;
	import data2.InterfaceSprite;
	import data2.layoutengine.LayoutEngine;
	import data2.math.Math2;
	import data2.text.Text;
	import fl.transitions.easing.Back;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ASCodeNavigation extends ASCode
	{
		public static const SCREEN_HOME:String = "screenHome";
		static public const SCREEN_INTRO:String = "screenIntro";
		public static const SCREEN_SELECTION:String = "screenSelection";
		public static const SCREEN_INTRO_GAME:String = "screenIntroGame";
		public static const SCREEN_GAME:String = "screenGame";
		
		
		private var _screen:String;
		
		
		public static const DOWN:String = "down";
		public static const TOP:String = "top";
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const NONE:String = "none";
		
		
		private var _items:Array;
		
		
		
		private var _twm:TweenManager;
		private var _perso:Sprite;
		private var _popupVisible:Boolean = false;
		private var _delay:Number;
		private var _subject:String;
		
		public function ASCodeNavigation() 
		{
			
		}
		
		override public function exec():void 
		{
			_items = [
				"titleMain",
				"home_btns",
				"header_main",
				"subtitle",
				"headerLang",
				"btn_back",
				"screen_intro",
				"selection_subject",
				"screen_intro_game",
				"screen_game_pyramide",
				"screen_game_equilibre",
				"screen_game_famille",
				/*"mascotte_left",
				"mascotte_right",*/
				"cache_popup",
				"popup",
			];
			
			var _nb:int = _items.length;
			for (var i:int = 0; i < _nb; i++) setItemVisible(_items[i], false);
			
			setItemVisible("titleMain", true);
			setItemVisible("home_btns", true);
			
			
			_twm = new TweenManager();
			_screen = SCREEN_HOME;
			
			disableAllClickable();
			setClickableItems(_screen);
		}
		
		
		
		
		public function gotoIntro():void 
		{
			_delay = 0;
			hideScreen(_screen);
			_delay += 0.2;
			_screen = SCREEN_INTRO;
			
			disableAllClickable();
			DelayManager.add("", 1000, setClickableItems, _screen);
			
			showScreen(_screen);
			
			animate("headerLang", true, TOP, _delay);  _delay += 0.0;
			animate("header_main", true, TOP, _delay);  _delay += 0.2;
		}
		
		
		public function gotoSelection():void 
		{
			_delay = 0;
			hideScreen(_screen);
			_screen = SCREEN_SELECTION;
			_delay += 0.2;
			disableAllClickable();
			DelayManager.add("", 1000, setClickableItems, _screen);
			showScreen(SCREEN_SELECTION);
			
		}
		
		
		public function gotoGame(_subj:String):void 
		{
			_delay = 0;
			_subject = _subj;
			hideScreen(_screen);
			_delay += 0.2;
			
			_screen = SCREEN_GAME;
			
			disableAllClickable();
			DelayManager.add("", 1000, setClickableItems, _screen);
			
			
			showScreen(SCREEN_GAME);
			
		}
		
		
		
		
		
		
		
		public function gotoHome():void
		{
			hideScreen(_screen);
			_delay += 0.2;
			
			_screen = SCREEN_HOME;
			disableAllClickable();
			DelayManager.add("", 1000, setClickableItems, _screen);
			
			animate("headerLang", false, TOP, _delay);  _delay += 0.0;
			animate("header_main", false, TOP, _delay);  _delay += 0.2;
			
			showScreen(SCREEN_HOME);
		}
		
		
		
		public function gotoScreenIntro(_subj:String):void 
		{
			setItemVisible("graph_intro_pyramide", false);
			setItemVisible("graph_intro_equilibre", false);
			setItemVisible("graph_intro_famille", false);
			setItemVisible("graph_intro_" + _subj, true);
			
			_delay = 0;
			
			hideScreen(_screen);
			_delay += 0.2;
			
			_screen = SCREEN_INTRO_GAME;
			disableAllClickable();
			DelayManager.add("", 1000, setClickableItems, _screen);
			showScreen(_screen);
			
			
		}
		
		
		
		
		public function gotoBack():void 
		{
			_delay = 0;
			hideScreen(_screen);
			_delay += 0.2;
			
			if (_screen == SCREEN_SELECTION) {
				animate("btn_back", false, TOP, _delay);  _delay += 0.2;
			}
			else if (_screen == SCREEN_INTRO_GAME || _screen == SCREEN_GAME) {
				animate("subtitle", false, TOP, _delay);  _delay += 0.2;
			}
			
			
			if (_screen == SCREEN_GAME || _screen == SCREEN_INTRO_GAME) _screen = SCREEN_SELECTION;
			else if (_screen == SCREEN_SELECTION) _screen = SCREEN_INTRO;
			
			disableAllClickable();
			DelayManager.add("", 1000, setClickableItems, _screen);
			
			
			
			showScreen(_screen);
		}
		
		
		
		//___________________________________________________________
		
		private function hideScreen(_sc:String):void
		{
			if (_sc == SCREEN_HOME) {
				animate("home_btns", false, DOWN, _delay); _delay += 0.15;
				animate("titleMain", false, DOWN, _delay);  _delay += 0.35;
			}
			else if (_sc == SCREEN_INTRO) {
				
				animate("screen_intro_circle", false, DOWN, _delay, 1000);  _delay += 0.15;
				animate("screen_intro_mascotte", false, DOWN, _delay);  _delay += 0.15;
			}
			else if (_sc == SCREEN_INTRO_GAME) {
				
				animate("graph_intro", false, DOWN, _delay, 1000);  _delay += 0.15;
				animate("screen_intro_circle2", false, DOWN, _delay, 1000);  _delay += 0.15;
				animate("screen_intro_mascotte2", false, DOWN, _delay);  _delay += 0.15;
			}
			
			else if (_sc == SCREEN_GAME) {
				
				animate("screen_game_"+_subject, false, DOWN, _delay, 1000);  _delay += 0.1;
			}
			else if (_sc == SCREEN_SELECTION) {
				//animate("mascotte_left", false, DOWN, _delay); _delay += 0.15;
				animate("selection_subject", false, DOWN, _delay, 1000); _delay += 0.15;
			}
		}
		
		private function showScreen(_sc:String):void 
		{
			if (_sc == SCREEN_HOME) {
				animate("titleMain", true, DOWN, _delay);  _delay += 0.15;
				animate("home_btns", true, DOWN, _delay); _delay += 0.1;
			}
			else if (_sc == SCREEN_INTRO) {
				setItemVisible("screen_intro", true);
				animate("screen_intro_circle", true, DOWN, _delay, 1000);  _delay += 0.25;
				animate("screen_intro_mascotte", true, DOWN, _delay);  _delay += 0.15;
			}
			
			else if (_sc == SCREEN_SELECTION) {
				animate("selection_subject", true, DOWN, _delay, 1000);  _delay += 0.45;
				//animate("mascotte_left", true, DOWN, _delay);  _delay += 0.1;
				animate("btn_back", true, TOP, _delay);  _delay += 0.2;
			}
			else if (_sc == SCREEN_INTRO_GAME) {
				setItemVisible("screen_intro_game", true);
				animate("graph_intro", true, DOWN, _delay, 1000);  _delay += 0.15;
				animate("screen_intro_circle2", true, DOWN, _delay, 1000);  _delay += 0.25;
				animate("screen_intro_mascotte2", true, DOWN, _delay);  _delay += 0.15;
				animate("subtitle", true, TOP, _delay);  _delay += 0.15;
			}
			
			else if (_sc == SCREEN_GAME) {
				
				animate("screen_game_"+_subject, true, DOWN, _delay, 1000);  _delay += 0.1;
				
				if (_subject == "pyramide") ASCodeGamePyramide(ObjectSearch.getID("ascodegamePyramide")).customAnim();
				else if (_subject == "equilibre") ASCodeEquilibre(ObjectSearch.getID("ascodegameEquilibre")).customAnim();
				else if (_subject == "famille") ASCodeGameFamilly(ObjectSearch.getID("ascodegameFamilly")).customAnim();
				
			}
		}
		
		
		
		
		public function setPopupContent(_msg:String):void
		{
			var _text:Text = Text(ObjectSearch.getID("popup_text"));
			_text.value = "<span class='popup_text'>" + _msg + "</span>";
			_text.updateText();
			
			var _bounds:Rectangle = _text.getTextBounds();
			if (_popup == null) _popup = InterfaceSprite(ObjectSearch.getID("popup"));
			if (_popupinternal == null) _popupinternal = InterfaceSprite(ObjectSearch.getID("popup_"));
			
			_popup.layoutHeight = _bounds.height + 48 * 2;
			_popupinternal.layoutHeight = _popup.layoutHeight;
			_popupinternal.updateGraphics();
			_popup.y = Math.round(LayoutEngine.layoutSize.y * 0.5 - _popup.layoutHeight * 0.5);
			
			
		}
		
		
		
		
		var _cachepopup:Sprite;
		var _popup:InterfaceSprite;
		var _popupinternal:InterfaceSprite;
		
		public function showPopup():void
		{
			_popupVisible = true;
			
			if (_cachepopup == null) _cachepopup = Sprite(ObjectSearch.getID("cache_popup"));
			if (_popup == null) _popup = InterfaceSprite(ObjectSearch.getID("popup"));
			if (_popupinternal == null) _popupinternal = InterfaceSprite(ObjectSearch.getID("popup_"));
			
			_twm.tween(_cachepopup, "alpha", 0, 1, 0.3);
			_cachepopup.visible = true;
			_twm.tween(_popupinternal, "y", -LayoutEngine.layoutSize.y * 0.7, 0, 0.4, 0.0, Back.easeOut);
			_popup.visible = true;
			
			
			setItemTouchable("popup", true);
		}
		
		public function hidePopup():void
		{
			_popupVisible = false;
			if (_cachepopup == null) _cachepopup = Sprite(ObjectSearch.getID("cache_popup"));
			if (_popup == null) _popup = InterfaceSprite(ObjectSearch.getID("popup"));
			if (_popupinternal == null) _popupinternal = InterfaceSprite(ObjectSearch.getID("popup_"));
			
			_twm.tween(_cachepopup, "alpha", 1, 0, 0.3);
			_twm.tween(_popupinternal, "y", 0, +LayoutEngine.layoutSize.y * 0.99, 0.2);
			
		}
		
		
		
		
		//________________________________________________________________________
		
		
		
		
		
		private function disableAllClickable():void
		{
			for (var i:int = 0; i < _items.length; i++) 
			{
				setItemTouchable(_items[i], false);
			}
		}
		
		private function setClickableItems(_screen:String):void
		{
			if (_screen == SCREEN_HOME) {
				setItemTouchable("titleMain", true);
				setItemTouchable("home_btns", true);
			}
			else if (_screen == SCREEN_INTRO) {
				setItemTouchable("screen_intro", true);
				setItemTouchable("headerLang", true);
			}
			else if (_screen == SCREEN_INTRO_GAME) {
				setItemTouchable("screen_intro_game", true);
				setItemTouchable("headerLang", true);
				setItemTouchable("btn_back", true);
			}
			else if (_screen == SCREEN_SELECTION) {
				setItemTouchable("selection_subject", true);
				//setItemTouchable("mascotte_left", true);
				setItemTouchable("headerLang", true);
				setItemTouchable("btn_back", true);
			}
			else if (_screen == SCREEN_GAME) {
				setItemTouchable("btn_back", true);
				setItemTouchable("screen_game_" + _subject, true);
				
				setItemTouchable("headerLang", true);
			}
			
			
		}
		
		
		
		
		public function setItemVisible(_id:String, _value:Boolean):void
		{
			var _obj:Sprite = Sprite(ObjectSearch.getID(_id));
			_obj.visible = _value;
		}
		
		
		private function setItemTouchable(_id:String, _value:Boolean):void
		{
			var _obj:Sprite = Sprite(ObjectSearch.getID(_id));
			_obj.mouseEnabled = _value;
			_obj.mouseChildren = _value;
		}
		
		
		
		private function animateZoom(_id:String, _delay:Number):void
		{
			var _time:Number = 0.3;
			
			var _obj:Sprite = Sprite(ObjectSearch.getID(_id));
			_obj.scaleX = _obj.scaleY = 0;
			_twm.tween(_obj, "scaleX", NaN, 1, _time, _delay, Back.easeOut);
			_twm.tween(_obj, "scaleY", NaN, 1, _time, _delay, Back.easeOut);
			
		}
		
		
		public function animate(__obj:*, _value:Boolean, _side:String, _delay:Number, __distslide:Number = 700, _fade:Boolean = false):void 
		{
			var _obj:Sprite;
			if (__obj is Sprite) {
				_obj = __obj;
			}
			else {
				_obj = Sprite(ObjectSearch.getID(__obj));
			}
			
			if (_value && !_obj.visible) _obj.visible = true;
			_obj = Sprite(_obj.getChildAt(0));
			
			var _timeanim:Number = 0.4;
			
			if (_fade) {
				var _alphasrc:Number = (_value) ? 0 : 1;
				var _alphadest:Number = (_value) ? 1 : 0;
				_obj.alpha = _alphasrc;
				_twm.tween(_obj, "alpha", NaN, _alphadest, _timeanim, _delay);
			}
			
			if (_side != NONE) {
				var _distslide:Number = __distslide;
				var _prop:String = (_side == LEFT || _side == RIGHT) ? "x" : "y";
				var _src:Number;
				var _dst:Number;
				
				if (_value) {
					_src = (_side == LEFT || _side == TOP) ? -_distslide : +_distslide;
					_dst = 0;
				}
				else {
					_src = 0;
					_dst = (_side == LEFT || _side == TOP) ? -_distslide : +_distslide; 
				}
				_obj[_prop] = _src;
				_twm.tween(_obj, _prop, _src, _dst, _timeanim, _delay);
			}
			
			
			
		}
		
		public function get screen():String { return _screen; }
		
		
		
		
	}

}