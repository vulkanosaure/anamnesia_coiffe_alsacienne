package model 
{
	import data2.asxml.Constantes;
	import data2.net.imageloader.ImageLoader;
	import flash.display.Loader;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ModelCollection 
	{
		static private var _rawdata:Object;
		static private var _rawtab:Array;
		
		public function ModelCollection() 
		{
			
		}
		
		public static function loadAllImg():void
		{
			_rawdata = Constantes.get("fr.collection.items");
			_rawtab = _rawdata["item"] as Array;
			var _len:int = _rawtab.length;
			
			var _listimg:Array = new Array();
			var _loader:Loader = new Loader();
			
			trace("ModelCollection.loadAllImg_______");
			
			for (var i:int = 0; i < _len; i++) 
			{
				var _obj:Object = _rawtab[i];
				var _pathbig:String = _obj.images.path_big;
				var _pathsmall:String = _obj.images.path_small;
				
				var _img:String = _obj.images.image;
				
				var _url:String = _pathbig + _img;
				
				if (_listimg.indexOf(_url) == -1) {
					trace("_url : " + _url);
					
					ImageLoader.add(_loader, _url, "");
					_listimg.push(_url);
				}
				
				var _tabvignettes:Array;
				
				if (_obj.images.vignettes == "") {
					_tabvignettes = [];
				}
				else {
					var _objvignettes:Object = _obj.images.vignettes.item;
					if (_objvignettes is String) _tabvignettes = [_objvignettes];
					else _tabvignettes = _objvignettes as Array;
				}
				
				var _len2:int = _tabvignettes.length;
				for (var j:int = 0; j < _len2; j++) 
				{
					var _imgvignette:String = _tabvignettes[j];
					var _url:String = _pathsmall + _imgvignette;
					
					if (_listimg.indexOf(_url) == -1) {
						trace("--- _url : " + _url);
						
						ImageLoader.add(_loader, _url, "");
						_listimg.push(_url);
					}
					
				}
				
				
			}
			ImageLoader.loadGroup("");
			
			
		}
		
		
		public static function getListArticle(_incontournable:Boolean, _filters:Array):Array
		{
			_rawdata = Constantes.get("fr.collection.items");
			_rawtab = _rawdata["item"] as Array;
			var _len:int = _rawtab.length;
			
			var _tab:Array = new Array();
			if (_incontournable) {
				
				for (var i:int = 0; i < _len; i++) 
				{
					var _obj:Object = _rawtab[i];
					if (_obj.incontournable == 1) _tab.push(_obj);
				}
				
			}
			else {
				
				for (var i:int = 0; i < _len; i++) 
				{
					var _obj:Object = _rawtab[i];
					if (_filters.indexOf(int(_obj.filtre)) != -1) _tab.push(_obj);
				}
			}
			
			return _tab;
		}
		
		
		
		
		static public function getIndexData(_data:Object):int 
		{
			var _len:int = _rawtab.length;
			for (var i:int = 0; i < _len; i++) 
			{
				if (_rawtab[i] == _data) return i;
			}
			return -1;
		}
		
		
	}

}