package view 
{
	import assets.compose.Component_compose_choice;
	import data2.asxml.Constantes;
	import data2.asxml.ObjectSearch;
	import data2.fx.delay.DelayManager;
	import data2.InterfaceSprite;
	import data2.mvc.ViewBase;
	import data2.net.imageloader.ImageLoader;
	import data2.net.imageloader.ImageLoaderEvent;
	import data2.net.imageloader.ImageLoaderObject;
	import data2.net.URLLoaderManager;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import model.translation.Translation;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ViewGameCompose extends ViewBase
	{
		private static const NB_MAX_ICON:int = 8;
		private static const ICON_DX:int = 240;
		private static const ICON_DY:int = 125;
		
		private static const NB_WIDTH:int = 4;
		private static var _listicons:Array;
		private static var _iconRepository:Object;
		static private var _clickedSituation:String;
		static private var _historySituation:Array;
		static private var _clickedItem:Component_compose_choice;
		static private var _isEnd:Boolean;
		static private var _listurl:Array;
		static private var _indexload:int;
		static private var _nofile:Boolean;
		
		public function ViewGameCompose() 
		{
			
		}
		
		public static function init_real():void
		{
			_iconRepository = new Object();
			_listicons = new Array();
			var _container:Sprite = getSprite("gamecompose_list_choice");
			for (var i:int = 0; i < NB_MAX_ICON; i++) 
			{
				var _item:Component_compose_choice = new Component_compose_choice();
				_container.addChild(_item);
				
				_item.clickableMargin = 6;
				_item.clickableMargin_horiz = 0;
				if (i < NB_WIDTH) _item.clickableMargin_top = 40;
				else _item.clickableMargin_bottom = 40;
				_listicons.push(_item);
				_item.index = i;
				_item.initComponent();
				_item.onmousedown = "as:#ascodegamecompose  onClickBtnChoice  " + i;
				_item.initOnClick(0);
			}
			
			
			//charge toutes les images
			
			_listurl = new Array();
			_indexload = 0;
			var _keyxmltab:String = "fr.game_compose.list_img";
			var _loader:Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImgLoaded);
			//ImageLoader.addEventListener(ImageLoaderEvent.IMG_COMPLETE, onImgLoaded);
			
			
			var _rawdata:Object = Constantes.get(_keyxmltab);
			var _rawtab:Array = _rawdata["item"] as Array;
			for (var j:int = 0; j < _rawtab.length; j++) 
			{
				var _name:String = _rawtab[j];
				var _namemin = _name;
				
				var _urlmin:String = "images/compose/min/" + _namemin + ".png";
				var _urlbig:String = "images/compose/big/" + _name + ".png";
				ImageLoader.add(_loader, _urlmin, "");
				ImageLoader.add(_loader, _urlbig, "");
				_listurl.push(_urlmin);
				_listurl.push(_urlbig);
				
				trace("_urls : " + _urlmin + " ///" + _urlbig);
				
			}
			ImageLoader.loadGroup();
			
			
		}
		
		
		static private function onImgLoaded(e:Event):void 
		{
			trace("ViewGameCompose.onImgLoaded");
			
			var _src:String = _listurl[_indexload];
			_src = _src.replace(new RegExp("[/.]", "g"), "_");
			trace("_src : " + _src);
			
			var _content:DisplayObject = LoaderInfo(e.currentTarget).loader.content;
			_iconRepository[_src] = _content;
			
			_indexload++;
		}
		
		/*
		static private function onImgLoaded(e:ImageLoaderEvent):void 
		{
			trace("ViewGameCompose.onImgLoaded " + e.group);
			
			if (e.group != "compose") return;
			
			var _src:String = e.src;
			_src = _src.replace(new RegExp("[/.]", "g"), "_");
			trace("_src : " + _src);
			
			_iconRepository[_src] = e.content;
			
		}
		*/
		
		
		public static function init():void
		{
			var _spconsignes:Sprite = getSprite("gamecompose_consignes");
			var _spfeedeback:Sprite = getSprite("gamecompose_feedback");
			var _spbottom:Sprite = getSprite("game_compose_bottom");
			var _spillus:Sprite = getSprite("gamecompose_imgbig_container");
			_spconsignes.visible = true;
			//_spconsignes.alpha = 1;
			_spillus.alpha = 0;
			_twm.tween(_spconsignes, "alpha", 0, 1, 0.3);
			
			_spfeedeback.visible = false;
			_spbottom.alpha = 0;
			_clickedSituation = "situation_init";
			_historySituation = [];
			
			
		}
		
		static public function gotoStart():void
		{
			_isEnd = false;
			
			var _spconsignes:Sprite = getSprite("gamecompose_consignes");
			var _spfeedeback:Sprite = getSprite("gamecompose_feedback");
			var _spbottom:Sprite = getSprite("game_compose_bottom");
			
			_twm.tween(_spfeedeback, "alpha", 1, 0, 0.3);
			
			DelayManager.add("", 500, function():void
			{
				init();
			});
			
		}
		
		
		static public function gotoSteps():void 
		{
			_isEnd = false;
			
			var _spconsignes:Sprite = getSprite("gamecompose_consignes");
			var _spbottom:Sprite = getSprite("game_compose_bottom");
			var _spillus:Sprite = getSprite("gamecompose_imgbig_container");
			
			_twm.tween(_spillus, "alpha", 0, 1, 0.3);
			_twm.tween(_spconsignes, "alpha", 1, 0, 0.2);
			_twm.tween(_spbottom, "alpha", 0, 1, 0.3, 0.2);
			
			
			var _container:Sprite = getSprite("gamecompose_imgbig_container");
			while (_container.numChildren) _container.removeChildAt(0);
			
		}
		
		static public function gotoFeedback():void
		{
			var _spfeedeback:Sprite = getSprite("gamecompose_feedback");
			var _spbottom:Sprite = getSprite("game_compose_bottom");
			var _spillus:Sprite = getSprite("gamecompose_imgbig_container");
			
			_twm.tween(_spbottom, "alpha", 1, 0, 0.4);
			//_twm.tween(_spillus, "alpha", 1, 0, 0.4);
			
			DelayManager.add("", 600, function():void {
				_twm.tween(_spfeedeback, "alpha", 0, 1, 0.4);
			});
			
		}
		
		
		
		static public function updateStep(_index:int, _bnext:Boolean):void
		{
			//
			trace("updateStep " + _index + ", " + _bnext);
			trace("_isEnd : " + _isEnd);
			
			var _situation:String = _clickedSituation;
			if (_bnext) {
				_historySituation.push(_situation);
			}
			else {
				_historySituation.splice(_historySituation.length - 1, 1);
				_situation = _historySituation[_historySituation.length - 1];
			}
			
			if (_bnext && _isEnd) {
				trace("END ! " + _situation);
				Translation.add("text_gamecompose_feedback", "game_compose.feedbacks." + _situation + ".texte", "FRM_19_646475", "text-align:center;");
				gotoFeedback();
				/*
				var _sp:DisplayObject = getIconSprite(_situation, "big");
				var _container:Sprite = getSprite("gamecompose_imgbig_container");
				while (_container.numChildren) _container.removeChildAt(0);
				_container.addChild(_sp);
				*/
			}
			else {
				
				Translation.add("text_compose_step_title", "game_compose.title_step", "FREB_36_646475", "text-align:center;", false, true);
				Translation.setContentVariable("x", String(_index + 1));
				
				trace("_historySituation : " + _historySituation);
				trace("_situation : " + _situation);
				
				
				var _keyxmltab:String = "fr.game_compose.situations." + _situation + ".items";
				
				var _rawdata:Object = Constantes.get(_keyxmltab);
				
				var _rawtab:Array;
				if (_rawdata["item"] is Array) {
					_rawtab = _rawdata["item"] as Array;
				}
				else {
					_rawtab = new Array();
					_rawtab.push(_rawdata["item"]);
				}
				
				
				
				trace("_rawtab : " + _rawtab);
				
				var _nbicon:int = _rawtab.length;
				
				var _iddesc:String = String(Constantes.get("fr.game_compose.situations." + _situation + ".desc"));
				var _iddesc2:String = String(Constantes.get("fr.game_compose.situations." + _situation + ".desc2"));
				trace("_iddesc : " + _iddesc);
				trace("_iddesc2 : " + _iddesc2);
				
				var _tabfilter:Array = ["text_compose_step_title", "text_compose_step_desc"];
				
				Translation.add("text_compose_step_desc", "game_compose.steps."+_iddesc + ".desc", "FRM_22_646475", "text-align:center;");
				
				if (_iddesc2 != "") {
					Translation.add("text_compose_step_desc2", "game_compose.steps."+_iddesc2 + ".desc", "FRM_22_646475", "text-align:center;");
					_tabfilter.push("text_compose_step_desc2");
					getText("text_compose_step_desc2").visible = true;
					getSprite("gamecompose_list_choice").y = 120 + 30;
				}
				else {
					getText("text_compose_step_desc2").visible = false;
					getSprite("gamecompose_list_choice").y = 120;
				}
				
				
				
				for (var i:int = 0; i < _nbicon; i++) 
				{
					//icon
					var _obj:Object = _rawtab[i];
					
					if (_obj == "") {
						_nbicon--;
						break;	//exception for bug 1 item not recognized
					}
					
					
					if ((_obj["nofile"] != "1")) {
						var _indexicon:String = _obj["img"];
						var _iconSprite:DisplayObject = getIconSprite(_indexicon, "min");
						Component_compose_choice(_listicons[i]).setIcon(_iconSprite);
						Component_compose_choice(_listicons[i]).imgbig = "" + _indexicon;
					}
					
					Component_compose_choice(_listicons[i]).situation = _obj["img"];
					Component_compose_choice(_listicons[i]).nofile = (_obj["nofile"] != undefined);
					Component_compose_choice(_listicons[i]).end = (_obj["end"] != undefined);
					
					
					if (_obj["nofile"] == "1") {
						_nbicon = 0;
						Component_compose_choice(_listicons[i]).end = (_obj["end"] != undefined);
						break;
					}
					
					
					if (Component_compose_choice(_listicons[i]).end) {
						trace("add one end here");
					}
					
					
					//name
					var _keyparam:String = "text_compose_kp_" + i;
					Translation.addDynamic("text_item_compose_" + i, "game_compose.situations." + _situation + ".items.item", "name", _keyparam, "FRB_15_646475");
					Translation.setDynamicIndex(_keyparam, i);
					_tabfilter.push("text_item_compose_" + i);
				}
				
				//update visibility
				
				var _basex:Number;
				
				
				
				for (var j:int = 0; j < NB_MAX_ICON; j++) {
					
					var _item:Component_compose_choice = Component_compose_choice(_listicons[j]);
					_item.visible = (j < _nbicon);
					if (_item.visible) {
						
						
						_basex = -53 + 540;
						var _nbwidth:int;
						
						if (j < NB_WIDTH) {
							_nbwidth = _nbicon;
							if (_nbwidth > NB_WIDTH) _nbwidth = NB_WIDTH;
						}
						else {
							_nbwidth = _nbicon - NB_WIDTH;
						}
						
						_basex -= (_nbwidth * ICON_DX - 164) * 0.5;
						_basex = Math.round(_basex);
						
						var _indexrow:int = j;
						_item.x = _basex + (_indexrow % NB_WIDTH) * ICON_DX;
						_item.y = Math.floor(_indexrow / NB_WIDTH) * ICON_DY;
					}
				}
			}
			
			
			
			Translation.translate("", _tabfilter);
			
			
		}
		
		
		static private function getIconSprite(_icon:String, _type:String):DisplayObject 
		{
			//type = min/big
			
			var _src:String = "images/compose/" + _type + "/" + _icon + ".png";
			_src = _src.replace(new RegExp("[/.]", "g"), "_");
			var _sp:DisplayObject = DisplayObject(_iconRepository[_src]);
			
			return _sp;
		}
		
		
		
		
		
		
		static public function updatePagination(_indexpage:int):void 
		{
			var _btnleft:InterfaceSprite = getISprite("btn_compose_left");
			var _btnright:InterfaceSprite = getISprite("btn_compose_right");
			
			var _alphadisabled:Number = 0.3;
			var _leftlock:Boolean = (_indexpage == 0);
			var _rightlock:Boolean = true;
			
			_btnleft.alpha = (_leftlock) ? _alphadisabled : 1.0;
			_btnleft.touchable = !_leftlock;
			
			_btnright.alpha = (_rightlock) ? _alphadisabled : 1.0;
			_btnright.touchable = !_rightlock;
			
			
		}
		
		static public function navigateStep(_index:int, _side:int):void 
		{
			var _sp:Sprite = getSprite("compose_zone_steps_sub");
			var _dist:Number = 100 * -_side;
			var _prop:String = "x";
			
			_twm.tween(_sp, "alpha", NaN, 0, 0.2);
			_twm.tween(_sp, _prop, 0, _dist, 0.2);
			
			DelayManager.add("", 200, function():void
			{
				trace("update and select, " + _isEnd);
				updateStep(_index, (_side == 1));
				if (!_isEnd) {
					setSelected(0);
				}
				
				_twm.tween(_sp, "alpha", NaN, 1, 0.3);
				_twm.tween(_sp, _prop, -_dist, 0, 0.3);
			});
			
		}
		
		
		static public function clickChoice(_index:int):void 
		{
			setSelected(_index);
			
		}
		
		static public function setSelected(_index:int):void
		{
			trace("ViewGameCompose.setSelected(" + _index + ")");
			
			var _item:Component_compose_choice = Component_compose_choice(_listicons[_index]);
			_isEnd = _item.end;
			_nofile = _item.nofile;
			trace("_isEnd : " + _isEnd + ", _nofile : " + _nofile);
			
			var _len:int = _listicons.length;
			if (!_nofile) {
				
				for (var i:int = 0; i < _len; i++) {
					Component_compose_choice(_listicons[i]).setSelected(false);
				}
				_item.setSelected(true);
				
				var _sp:DisplayObject = getIconSprite(_item.imgbig, "big");
				var _container:Sprite = getSprite("gamecompose_imgbig_container");
				while (_container.numChildren) _container.removeChildAt(0);
				_container.addChild(_sp);
			
			}
			else {
				for (var i:int = 0; i < _len; i++) {
					Component_compose_choice(_listicons[i]).visible = false;
				}
				
			}
			
			
			_clickedItem = _item;
			_clickedSituation = _item.situation;
			
			trace("_clickedSituation : " + _clickedSituation);
			
			
			var _btnright:InterfaceSprite = getISprite("btn_compose_right");
			var _rightlock:Boolean = false;
			_btnright.alpha = (_rightlock) ? 0.3 : 1.0;
			_btnright.touchable = !_rightlock;
			
		}
		
		static public function setBtnEnabled(_id:String, _value:Boolean):void 
		{
			getISprite(_id).touchable = _value;
		}
		
	}

}