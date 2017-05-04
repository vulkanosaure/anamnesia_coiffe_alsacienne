package view 
{
	import assets.collection.Component_article_listing;
	import assets.collection.Component_collection_pagination;
	import assets.collection.Component_image_collection_big;
	import assets.collection.Component_vignette_big;
	import assets.collection.Component_vignette_small;
	import data2.asxml.ObjectSearch;
	import data2.fx.delay.DelayManager;
	import data2.fx.swipe.SwipeEvent;
	import data2.fx.swipe.SwipeHandler;
	import data2.InterfaceSprite;
	import data2.mvc.ViewBase;
	import data2.navigation.Navigation;
	import data2.navigation.NavigationDef;
	import data2.net.imageloader.ImageLoader;
	import data2.text.Text;
	import fl.transitions.easing.None;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import model.ModelCollection;
	import model.translation.Translation;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ViewCollection extends ViewBase
	{
		
		private static const NB_PER_PAGE:int = 12;
		private static const NB_COLUMN:int = 3;
		
		private static var _listArticles:Array;
		private static var _listVignettes:Array;
		static private var _delta:Point = new Point(360, 315);
		
		
		public function ViewCollection() 
		{
			
		}
		
		static public function updateFooter(_isIncontournable:Boolean):void 
		{
			var _footerinc:Sprite = Sprite(ObjectSearch.getID("footer_inc"));
			var _zonepag:Sprite = Sprite(ObjectSearch.getID("zone_pagination"));
			
			_footerinc.visible = _isIncontournable;
			_zonepag.visible = !_isIncontournable;
			
		}
		
		
		
		
		static public function initList(_stage:Stage):void
		{
			var _container:Sprite = Sprite(ObjectSearch.getID("list_articles_items"));
			
			
			if (_listArticles == null) {
				_listArticles = new Array();
				for (var j:int = 0; j < DataGlobal.NB_ARTICLE_PER_PAGE; j++) 
				{
					var _is:InterfaceSprite = new InterfaceSprite();
					_container.addChild(_is);
					var _detail:Component_article_listing = new Component_article_listing();
					_detail.index = j;
					_is.x = j % NB_COLUMN * _delta.x;
					_is.y = Math.floor(j / NB_COLUMN) * _delta.y;
					_is.addChild(_detail);
					_detail.initComponent();
					
					_is.onmousedown = "as:#ascodecollection  onClickDetail  " + j;
					_is.initOnClick(0);
					
				}
			}
			
			var _containerPagination:Sprite = getSprite("pagination_puces");
			_pagination = new Component_collection_pagination();
			_pagination.initComponent();
			_containerPagination.addChild(_pagination);
			
		}
		
		
		
		static public function updateList(_listArticle:Array, _page:int):void 
		{
			var _container:Sprite = Sprite(ObjectSearch.getID("list_articles_items"));
			
			var _indexstart:int = _page * NB_PER_PAGE;
			var _indexend:int = _indexstart + NB_PER_PAGE;
			if (_indexend > _listArticle.length) _indexend = _listArticle.length;
			
			
			
			
			
			for (var j:int = 0; j < DataGlobal.NB_ARTICLE_PER_PAGE; j++) 
			{
				var _indextab:int = _indexstart + j;
				
				var _is:InterfaceSprite = InterfaceSprite(_container.getChildAt(j));
				var _detail:Component_article_listing = Component_article_listing(_is.getChildAt(0));
				
				if (_indextab < _indexend) {
					var _obj:Object = _listArticle[_indextab];
					
					var _indexraw:int = ModelCollection.getIndexData(_obj);
					trace("_indexraw : " + _indexraw);
					var _idtext:String = "text_collection_listing_" + j;
					Translation.setDynamicIndex(_idtext, _indexraw);
					
					_detail.urlimg = String(_obj.images.path_small + _obj.images.image);
					/*
					_detail.desc = String(_obj.texts.title);
					*/
					_detail.updateComponent(); 
					_is.visible = true;
				}
				else {
					_is.visible = false;
					
				}
			}
			
			_container.alpha = 0;
			_twm.tween(_container, "alpha", NaN, 1, 0.5, 0.0, None.easeNone);
			
			
			
			
			ImageLoader.loadGroup();
			Translation.translate("");
			
		}
		
		
		
		
		static private function getIndexRawPosition(_indexraw:int):int
		{
			var _container:Sprite = Sprite(ObjectSearch.getID("list_articles_items"));
			for (var j:int = 0; j < DataGlobal.NB_ARTICLE_PER_PAGE; j++) 
			{
				var _is:InterfaceSprite = InterfaceSprite(_container.getChildAt(j));
				var _detail:Component_article_listing = Component_article_listing(_is.getChildAt(0));
				if (_detail.indexRaw == _indexraw) {
					return j;
				}
			}
			return -1;
		}
		
		
		
		
		static public function updatePagination(_indexpage:int, _pagetotal:int):void 
		{
			var _btnleft:InterfaceSprite = InterfaceSprite(ObjectSearch.getID("btn_pagination_left"));
			var _btnright:InterfaceSprite = InterfaceSprite(ObjectSearch.getID("btn_pagination_right"));
			
			var _alphadisabled:Number = 0.5;
			var _leftlock:Boolean = (_indexpage == 0);
			var _rightlock:Boolean = (_indexpage >= _pagetotal - 1);
			
			_btnleft.alpha = (_leftlock) ? _alphadisabled : 1.0;
			_btnleft.touchable = !_leftlock;
			
			_btnright.alpha = (_rightlock) ? _alphadisabled : 1.0;
			_btnright.touchable = !_rightlock;
			
			_pagination.select(_indexpage);
			
			var _paginationVisible:Boolean = (_pagetotal > 1);
			_pagination.visible = _paginationVisible;
			_btnleft.visible = _paginationVisible;
			_btnright.visible = _paginationVisible;
			
		}
		
		static public function lockBtnNavigation(_value:Boolean, _prefix:String):void
		{
			var _btnleft:InterfaceSprite = InterfaceSprite(ObjectSearch.getID(_prefix + "left"));
			var _btnright:InterfaceSprite = InterfaceSprite(ObjectSearch.getID(_prefix + "right"));
			
			_btnleft.touchable = !_value;
			_btnright.touchable = !_value;
		}
		
		
		static public function isNavigationLocked(_side:String, _prefix:String):Boolean
		{
			var _btn:InterfaceSprite = InterfaceSprite(ObjectSearch.getID(_prefix + _side));
			return !_btn.touchable;
		}
		
		
		
		
		
		static public function setPaginationNumber(_nbpage:int):void 
		{
			_pagination.nbitem = _nbpage;
			_pagination.updateComponent();
			
			//center _pagination
			var _containerPagination:Sprite = getSprite("pagination_puces");
			
			var _width:Number = Component_collection_pagination.DELTAX * (_nbpage - 1);
			_containerPagination.x = Math.round(1080 * 0.5 - _width * 0.5);
			
			var _margin:Number = 40;
			var _btnleft:Sprite = getSprite("btn_pagination_left");
			_btnleft.x = Math.round(1080 * 0.5 - _width * 0.5 - _margin - 213);
			
			var _btnright:Sprite = getSprite("btn_pagination_right");
			_btnright.x = Math.round(1080 * 0.5 + _width * 0.5 + _margin);
			
		}
		
		
		
		
		static public function updatePaginationVignette(_indexvignette:int):void 
		{
			var _vignettetotal:int = _tabvignette.length;
			
			var _btnleft:InterfaceSprite = getISprite("btn_detail_vignette_left");
			var _btnright:InterfaceSprite = getISprite("btn_detail_vignette_right");
			
			var _alphadisabled:Number = 0.4;
			var _leftlock:Boolean = (_indexvignette == 0);
			var _rightlock:Boolean = (_indexvignette >= _vignettetotal - 1);
			
			_btnleft.alpha = (_leftlock) ? _alphadisabled : 1.0;
			_btnleft.touchable = !_leftlock;
			
			_btnright.alpha = (_rightlock) ? _alphadisabled : 1.0;
			_btnright.touchable = !_rightlock;
		}
		
		
		
		
		
		
		static public function updatePaginationDetail(_indexdetail:int, _detailtotal:int):void 
		{
			var _btnleft:InterfaceSprite = getISprite("btn_detail_left");
			var _btnright:InterfaceSprite = getISprite("btn_detail_right");
			
			var _alphadisabled:Number = 0.4;
			var _leftlock:Boolean = (_indexdetail == 0);
			var _rightlock:Boolean = (_indexdetail >= _detailtotal - 1);
			
			_btnleft.alpha = (_leftlock) ? _alphadisabled : 1.0;
			_btnleft.touchable = !_leftlock;
			
			_btnright.alpha = (_rightlock) ? _alphadisabled : 1.0;
			_btnright.touchable = !_rightlock;
		}
		
		
		
		
		
		static public function updateDetail(_data:Object):void 
		{
			//list vignettes
			var _containerVignette:Sprite = getSprite("list_details_min");
			if (_listVignettes == null) {
				
				_listVignettes = new Array();
				for (var i:int = 0; i < 8; i++) 
				{
					var _is:InterfaceSprite = new InterfaceSprite();
					_containerVignette.addChild(_is);
					var _detail:Component_vignette_small = new Component_vignette_small();
					_is.addChild(_detail);
					_detail.initComponent();
					_is.x = i * 109;
					_listVignettes.push(_is);
					_is.clickableMargin = 10;
					_is.clickableMargin_vert = 35;
					_is.onmousedown = "as:#ascodecollection  onClickVignette  " + i;
					_is.initOnClick(0);
					
				}
				
			}
			
			
			if (_data.images.vignettes == "") {
				_tabvignette = [];
			}
			else {
				var _obj:* = _data.images.vignettes.item;
				if (_obj is String) _tabvignette = [_obj];
				else _tabvignette = _data.images.vignettes.item;
			}
			
			var _nbvignette:int = _tabvignette.length;
			trace("_nbvignette : " + _nbvignette);
			
			for (var i:int = 0; i < 8; i++) 
			{
				var _is:InterfaceSprite = InterfaceSprite(_listVignettes[i]);
				var _vignetteSmall:Component_vignette_small = Component_vignette_small(_is.getChildAt(0));
				
				if (i < _nbvignette) {
					_is.visible = true;
					_vignetteSmall.urlimg = _data.images.path_small + _tabvignette[i];
					_vignetteSmall.updateComponent();
				}
				else {
					_is.visible = false;
				}
			}
			
			
			//image main
			var _componentImgBig:Component_image_collection_big = Component_image_collection_big(getID("component_img_col_big"));
			if (!_componentImgBig.isInit) {
				_componentImgBig.initComponent();
			}
			
			_componentImgBig.urlimg = _data.images.path_big + "image.png";
			_componentImgBig.urlimgbig = _data.images.path_big + "image-zoom.png";
			_componentImgBig.updateComponent(true);
			_bupdateImgDebug = false;
			
			
			ImageLoader.loadGroup();
			
			
			
		}
		
		
		static public function gotoDetail(_value:Boolean, _animate:Boolean):void
		{
			if (_animate) {
				
				var _delay2:Number = (_value) ? 0.0 : 0.0;
				
				Navigation.animate("detail_zone_top", _value, NavigationDef.NONE, 0, 0, true, 0.4);
				Navigation.animate("subheader_collection", !_value, NavigationDef.NONE, _delay2, 0, true, 0.4);
			}
			else {
				/*
				getSprite("detail_zone_top").visible = _value;
				getSprite("subheader_collection").visible = _value;
				*/
				Navigation.animateNoAnim("detail_zone_top", _value);
				Navigation.animateNoAnim("subheader_collection", !_value);
			}
			
			showFooter(_value, _animate);
			
			
			
			
		}
		
		
		
		
		
		static public function showFooter(_value:Boolean, _animate:Boolean):void
		{
			var _footer:Sprite = getSprite("detail_zone_text");
			var _footersub:Sprite = Sprite(_footer.getChildAt(0));
			var _valuehidden:Number = 700;
			
			if (!_animate) {
				_footersub.visible = _value;
			}
			else {
				_footersub.visible = true;
				_footersub.y = _value ? _valuehidden : 0;
				var _endvalue:Number = _value ? 0 : _valuehidden;
				var _delay:Number = (_value) ? 0.0 : 0.0;
				_twm.tween(_footersub, "y", NaN, _endvalue, 0.4, _delay);
			}
		}
		
		
		
		static public function updateVignetteBig(_urlbig:String):void 
		{
			var _componentBig:Component_vignette_big = getID("component_vignette_big") as Component_vignette_big;
			_componentBig.urlimg = _urlbig;
			_componentBig.updateComponent();
			ImageLoader.loadGroup();
			
		}
		
		
		private static var _vignetteVisible:Boolean = false;
		static private var _tabvignette:Array;
		static private var _isZoomed:Boolean;
		static private var _pagination:Component_collection_pagination;
		static private var _bupdateImgDebug:Boolean = true;
		
		static public function showVignette(_value:Boolean, _animate:Boolean):void
		{
			trace("showVignette(" + _value + ", " + _animate + ")");
			
			var _timeanim:Number = (_animate) ? 0.2 : 0.01;
			
			if (!_animate) {
				Navigation.animateNoAnim("collection_vignette_big", _value);
				Navigation.animateNoAnim("collection_image_big", !_value);
			}
			else if (_vignetteVisible != _value) {
				
				Navigation.animate("collection_vignette_big", _value, NavigationDef.ZOOM, 0, 0, true, _timeanim);
				Navigation.animate("collection_image_big", !_value, NavigationDef.NONE, 0, 0, true, _timeanim);
				
			}
			
			getSprite("detail_btn_navigations").visible = !_value;
			getSprite("detail_btn_navigations_vignettes").visible = _value;
			
			_vignetteVisible = _value;
		}
		
		
		static public function isVignetteVisible():Boolean
		{
			return _vignetteVisible;
		}
		
		
		static public function updateListVignettes(_indexselected:int):void 
		{
			var _nbvignette:int = _tabvignette.length;
			
			for (var i:int = 0; i < _nbvignette; i++) 
			{
				var _selected:Boolean = i == _indexselected;
				
				var _is:InterfaceSprite = InterfaceSprite(_listVignettes[i]);
				var _vignetteSmall:Component_vignette_small = Component_vignette_small(_is.getChildAt(0));
				_vignetteSmall.setSelected(_selected);
			}
			
		
			
		}
		
		static public function setZoom(_zoom:Boolean):void 
		{
			_isZoomed = _zoom;
			getSprite("btn_zoom").visible = !_zoom;
			getSprite("btn_dezoom").visible = _zoom;
			
			var _componentImgBig:Component_image_collection_big = Component_image_collection_big(getID("component_img_col_big"));
			_componentImgBig.setScale(_zoom);
			
			getSprite("help_details").visible = !_zoom;
			getSprite("list_details_min").visible = !_zoom;
			
			
		}
		
		static public function isZoomed():Boolean 
		{
			return _isZoomed;
		}
		
		static public function switchZoom():void 
		{
			setZoom(!_isZoomed);
		}
		
		static public function onDescriptionChange(_textDesc:Text):void 
		{
			var _textTitle:Text = getText("detail_title_text");
			var _textAddress:Text = getText("detail_address_text");
			
			_textAddress.y = _textTitle.y + _textTitle.getTextBounds().height + 10;
			_textDesc.y = _textAddress.y + _textAddress.getTextBounds().height + 40;
			
		}
		
		static public function slideDetail(_delta:int, _type:String, _containerID:String):void 
		{
			var _container:Sprite = getSprite(_containerID);
			
			var _start:Number = (_type == "out") ? NaN : -_delta * 1024;
			var _end:Number = (_type == "out") ? _delta * 1024 : 0;
			
			_twm.tween(_container, "x", _start, _end, 0.27);
			
		}
		
		
		
		
		
		
		
	}

}