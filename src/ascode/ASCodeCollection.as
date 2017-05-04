package ascode 
{
	import data2.asxml.ASCode;
	import data2.asxml.ObjectSearch;
	import data2.fx.delay.DelayManager;
	import data2.fx.swipe.SwipeEvent;
	import data2.fx.swipe.SwipeHandler;
	import events.BroadCaster;
	import flash.display.Sprite;
	import flash.events.Event;
	import model.ModelCollection;
	import model.ModelImgBig;
	import model.translation.Translation;
	import view.ViewCollection;
	import view.ViewHeader;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ASCodeCollection extends ASCode
	{
		private var _listArticles:Array;
		
		private var _filterEnabled:Array;
		private var _isIncontournable:Boolean;
		private var _indexpage:int;
		private var _pagetotal:int;
		private var _indexdetail:int;
		private var _indexvignette:int;
		private var _swipeHandler:SwipeHandler;
		private var _swipeHandlerV:SwipeHandler;
		
		
		public function ASCodeCollection() 
		{
			
		}
		override public function exec():void 
		{
			BroadCaster.addEventListener("DOUBLE_CLICK_COLLECTION", onDoubleClickZoom);
			ViewCollection.initList(_stage);
			
			
			
			//swipe
			var _detailSwipe:Sprite = Sprite(ObjectSearch.getID("detail_slidable"));
			_swipeHandler = new SwipeHandler();
			_swipeHandler.init(_stage, _detailSwipe, 1080);
			_swipeHandler.addEventListener(SwipeEvent.SWIPE, onSwipe);
			
			
			var _detailSwipeV:Sprite = Sprite(ObjectSearch.getID("collection_vignette_big_sub"));
			_swipeHandlerV = new SwipeHandler();
			_swipeHandlerV.init(_stage, _detailSwipeV, 1080);
			_swipeHandlerV.addEventListener(SwipeEvent.SWIPE, onSwipeVignette);
			
			ModelCollection.loadAllImg();
			
		}
		
		
		
		
		
		public function initScreen(__isIncontournable:Boolean):void 
		{
			trace("ASCodeCollection.initScreen(" + _isIncontournable + ")");
			
			_isIncontournable = __isIncontournable;
			_filterEnabled = [];
			for (var i:int = 0; i < DataGlobal.NB_FILTERS; i++) _filterEnabled.push(i + 1);
			_indexpage = 0;
			
			
			var _bgcolor:uint = (_isIncontournable) ? 0xb8ad9e : 0xc58f39;
			var _filtervisible:Boolean = !_isIncontournable;
			ViewHeader.updateHeader(_bgcolor, _filtervisible);
			ViewCollection.updateFooter(_isIncontournable);
			ViewHeader.updateFilter(_filterEnabled);
			
			ViewCollection.gotoDetail(false, false);
			
			updateList(true);
			
			
		}
		
		
		
		public function onClickFilter(_index:int):void
		{
			trace("ASCodeCollection.onClickFilter(" + _index + ")");
			
			_indexpage = 0;
			
			var _indexof:int = _filterEnabled.indexOf(_index);
			
			if (_indexof != -1) {
				if (_filterEnabled.length <= 1) return;
				_filterEnabled.splice(_indexof, 1);
			}
			else _filterEnabled.push(_index);
			
			ViewHeader.updateFilter(_filterEnabled);
			
			updateList(true);
			
		}
		
		
		
		
		public function onClickChangePage(_delta:int):void
		{
			trace("onClickChangePage " + _delta);
			if (_indexpage == 0 && _delta == -1) return;
			//if(_indexpage
			_indexpage += _delta;
			
			updateList(false);
			
			
		}
		
		
		
		
		
		
		private function onSwipe(e:SwipeEvent):void 
		{
			trace("ASCodeCollection.onSwipe " + e.delta);
			
			var _transitionOK:Boolean = (e.delta == -1 && !ViewCollection.isNavigationLocked("left", "btn_detail_")) || (e.delta == +1 && !ViewCollection.isNavigationLocked("right", "btn_detail_"));
			
			if (_transitionOK) transitionDetail(e.delta);
			else _swipeHandler.cancelSwipe();
			
		}
		
		private function onSwipeVignette(e:SwipeEvent):void 
		{
			trace("onSwipeVignette " + e.delta);
			var _transitionOK:Boolean = (e.delta == -1 && !ViewCollection.isNavigationLocked("left", "btn_detail_vignette_")) || (e.delta == +1 && !ViewCollection.isNavigationLocked("right", "btn_detail_vignette_"));
			
			if (_transitionOK) transitionVignette(e.delta);
			else _swipeHandlerV.cancelSwipe();
		}
		
		
		public function onClickDetailChange(_delta:int):void
		{
			trace("ASCodeCollection.onClickDetailChange " + _delta);
			
			transitionDetail(_delta);
			
			
		}
		
		private function transitionDetail(_delta:int):void 
		{
			ViewCollection.slideDetail(-_delta, "out", "detail_slidable");
			ViewCollection.lockBtnNavigation(true, "btn_detail_");
			
			DelayManager.add("", 270, function(_d:int):void {
				
				_indexdetail += _d;
				updateDetail();
				ViewCollection.slideDetail( -_delta, "in", "detail_slidable");
				
			}, _delta);
			
			
		}
		
		
		public function onClickVignetteChange(_delta:int):void
		{
			trace("ASCodeCollection.onClickVignetteChange " + _delta);
			
			transitionVignette(_delta);
			
		}
		
		
		
		private function transitionVignette(_delta:int, _forceindex:int = -1):void 
		{
			ViewCollection.slideDetail(-_delta, "out", "collection_vignette_big_sub");
			ViewCollection.lockBtnNavigation(true, "btn_detail_vignette_");
			
			DelayManager.add("", 270, function(_d:int, _fi:int):void {
				
				if (_fi != -1) _indexvignette = _fi;
				else _indexvignette += _d;
				updateVignette();
				
				ViewCollection.slideDetail( -_delta, "in", "collection_vignette_big_sub");
				
			}, _delta, _forceindex);
			
			//_________________________
			
			
		}
		
		
		
		
		
		
		public function onClickDetail(_index:int):void
		{
			trace("onClickDetail(" + _index + ")");
			
			_indexdetail = _indexpage * DataGlobal.NB_ARTICLE_PER_PAGE + _index;
			
			updateDetail();
			
			ViewCollection.gotoDetail(true, true);
			
		}
		
		public function onClickDetailBack():void
		{
			ViewCollection.gotoDetail(false, true);
		}
		
		
		public function onClickVignette(_index:int):void
		{
			trace("ASCodeCollection.onClickVignette " + _index);
			if (ViewCollection.isVignetteVisible() && _index == _indexvignette) return;
			
			var _delta:int = (_index > _indexvignette) ? +1 : -1;
			_indexvignette = _index;
			
			if (ViewCollection.isVignetteVisible()) {
				
				ViewCollection.updateListVignettes(_indexvignette);
				transitionVignette(_delta, _index);
			}
			else {
				updateVignette();
			}
			
			
		}
		
		
		private function updateVignette():void 
		{
			var _data:Object = _listArticles[_indexdetail];
			
			var _items:Array;
			if (_data.images.vignettes.item is String) _items = [_data.images.vignettes.item];
			else _items = _data.images.vignettes.item;
			
			var _urlsmall:String = _data.images.path_small + _items[_indexvignette];
			var _urlbig:String = _data.images.path_big + _items[_indexvignette];
			
			ViewCollection.updateVignetteBig(_urlbig);
			ViewCollection.showVignette(true, true);
			ViewCollection.updateListVignettes(_indexvignette);
			ViewCollection.updatePaginationVignette(_indexvignette);
			
			_swipeHandler.enable(false);
			_swipeHandlerV.enable(true);
		}
		
		public function onCloseVignette():void
		{
			trace("ASCodeCollection.onCloseVignette");
			ViewCollection.showVignette(false, true);
			ViewCollection.updateListVignettes( -1);
			ViewCollection.setZoom(false);
			_swipeHandler.enable(!ViewCollection.isZoomed());
			_swipeHandlerV.enable(false);
		}
		
		
		
		
		//_______________________________________________________________________________________________
		//main image
		
		public function onClickZoom(_zoomed:Boolean):void
		{
			ViewCollection.setZoom(_zoomed);
			_swipeHandler.enable(!ViewCollection.isZoomed());
			
			
		}
		private function onDoubleClickZoom(e:Event):void
		{
			trace("onDoubleClickZoom");
			ViewCollection.switchZoom();
			_swipeHandler.enable(!ViewCollection.isZoomed());
		}
		
		
		
		
		
		
		
		
		
		//______________________________________________________________________________________________
		
		private function updateList(_updateData:Boolean):void 
		{
			if (_updateData) {
				_listArticles = ModelCollection.getListArticle(_isIncontournable, _filterEnabled);
				_pagetotal = Math.ceil(_listArticles.length / DataGlobal.NB_ARTICLE_PER_PAGE);
				
				ViewCollection.setPaginationNumber(_pagetotal);
				
			}
			
			trace("_listArticles.length : " + _listArticles.length);
			
			ViewCollection.updateList(_listArticles, _indexpage);
			
			ViewCollection.updatePagination(_indexpage, _pagetotal);
		}
		
		
		
		
		
		
		private function updateDetail():void
		{
			var _data:Object = _listArticles[_indexdetail];
			
			var _indexraw:int = ModelCollection.getIndexData(_data);
			Translation.setDynamicIndex("index_article", _indexraw);
			Translation.translate("", ["detail_title_text", "detail_desc_text", "detail_address_text", "detail_materiaux_text", "legend_coiffe_text"]);
			
			ViewCollection.updateDetail(_data);
			ViewCollection.updatePaginationDetail(_indexdetail, _listArticles.length);
			ViewCollection.updateListVignettes( -1);
			ViewCollection.showVignette(false, false);
			ViewCollection.setZoom(false);
			_swipeHandler.enable(!ViewCollection.isZoomed());
			_swipeHandlerV.enable(false);
			
			
		}
		
		
		
		
		
	}

}