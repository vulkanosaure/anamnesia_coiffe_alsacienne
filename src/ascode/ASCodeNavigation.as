package ascode 
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
		public static const SCREEN_SELECTION:String = "screenSelection";
		public static const SCREEN_GAME:String = "screenGame";
		
		
		private var _screen:String;
		
		
		private static const DOWN:String = "down";
		private static const TOP:String = "top";
		private static const LEFT:String = "left";
		private static const RIGHT:String = "right";
		private static const NONE:String = "none";
		
		
		private var _twm:TweenManager;
		private var _perso:Sprite;
		private var _popupVisible:Boolean = false;
		
		public function ASCodeNavigation() 
		{
			
		}
		
		override public function exec():void 
		{
			_twm = new TweenManager();
			_screen = SCREEN_HOME;
			
			disableAllClickable();
			setClickableItems(_screen);
		}
		
		
		
		public function gotoSelection():void 
		{
			_screen = SCREEN_SELECTION;
			
			DataGlobal.videomc.visible = false;
			DataGlobal.videomc.stop();
			
			
			disableAllClickable();
			DelayManager.add("", 1300, setClickableItems, _screen);
			
			
			/*
			var _delay:Number = 0;
			animate("home_btns", false, DOWN, _delay);
			_delay += 0.1;
			//animate("home_deco", false, NONE, _delay);
			_delay += 0.1;
			animate("titleMain", false, DOWN, _delay);
			_delay += 0.2;
			*/
			
			
			
			
		}
		
		
		
		
		
		
		
		public function gotoHome():void
		{
			
			
			disableAllClickable();
			DelayManager.add("", 1000, setClickableItems, _screen);
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
			var _list:Array = [/*"selection_perso", "headerMain", "headerLang_white", "headerLang_blue", "home_btns", "zone_right"*/];
			for (var i:int = 0; i < _list.length; i++) 
			{
				setItemTouchable(_list[i], false);
			}
		}
		
		private function setClickableItems(_screen:String):void
		{
			if (_screen == SCREEN_HOME) {
				//setItemTouchable("home_btns", true);
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
		
		
		
		private function animate(__obj:*, _value:Boolean, _side:String, _delay:Number, __distslide:Number = 300, _fade:Boolean = true):void 
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
			
			var _timeanim:Number = 0.5;
			
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