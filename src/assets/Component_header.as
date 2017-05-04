package assets
{
	import ascode.ASCodeMenu;
	import assets.collection.Component_collection_filter;
	import data.display.FilledRectangle;
	import data2.asxml.ObjectSearch;
	import data2.InterfaceSprite
	import data2.text.Text
	import flash.display.Sprite
	import flash.events.MouseEvent;
	
	public class Component_header extends InterfaceSprite
	{
		private var _listFilters:Array;
		
		private var _bgcolor:uint;
		private var _bg:FilledRectangle;
		private var _typevisible:Boolean = false;
		private var _spFilters:Sprite;
		
		public function Component_header()
		{
			initComponent();
		}
		
		public function initComponent():void
		{
			_bg = new FilledRectangle(0x777777);
			_bg.width = 1080; _bg.height = 162;
			this.addChild(_bg);
			
			
			var _is1:Sprite = new Sprite();
			this.addChild(_is1);
			_is1.x = 123; _is1.y = 91; 
			
			var _text0:Text = new Text();
			_is1.addChild(_text0);
			_text0.width = 700;
			_text0.embedFonts = true;
			//_text0.value = "<span class='MS500_19_FFFFFF'>Sélectionnez une coiffe pour en savoir plus...</span>";
			_text0.value = "";
			_text0.updateText();
			ObjectSearch.registerID(_text0, "text_subtitle_header", false);
			
			var _is2:Sprite = new Sprite();
			this.addChild(_is2);
			_is2.x = 123; _is2.y = 43; 
			
			var _text1:Text = new Text();
			_is2.addChild(_text1);
			_text1.width = 700;
			_text1.embedFonts = true;
			//_text1.value = "<span class='MS900_36_FFFFFF'>LES INCONTOURNABLES</span>";
			_text1.value = "";
			_text1.updateText();
			ObjectSearch.registerID(_text1, "text_title_header", false);
			
			var _is3:InterfaceSprite = new InterfaceSprite();
			this.addChild(_is3);
			_is3.x = 47; _is3.y = 37; 
			
			var _is4:Sprite = new asset_btn_back();
			_is3.addChild(_is4);
			
			_is3.clickableMargin = 40;
			_is3.onmousedown = "as:#ascodemenu  onClickBack";
			ObjectSearch.registerID(_is3, "header_btn_back", false);
			_is3.initOnClick(0);
			//_is4.addEventListener(MouseEvent.MOUSE_DOWN, onClickBtnBack);
			
			var _is5:Sprite = new Sprite();
			_is4.addChild(_is5);
			
			
			
			_spFilters = new Sprite();
			_spFilters.x = 818 - 30; _spFilters.y = 37;
			this.addChild(_spFilters);
			
			_listFilters = new Array();
			for (var i:int = 0; i < DataGlobal.NB_FILTERS; i++) 
			{
				var _is:InterfaceSprite = new InterfaceSprite();
				
				var _filter:Component_collection_filter = new Component_collection_filter();
				_filter.text = "TYPE " + (i + 1);
				_filter.index = (i + 1);
				_filter.initComponent();
				_spFilters.addChild(_is);
				_is.addChild(_filter);
				_filter.x = i * 98 + 50;
				_is.clickableMargin = 0;
				_is.clickableMargin_vert = 30;
				_is.onmousedown = "as:#ascodecollection  onClickFilter  " + (i + 1);
				_is.initOnClick(0);
				
				_listFilters.push(_filter);
				
			}
			
		}
		
		
		
		public function update():void
		{
			_bg.color = _bgcolor;
			_spFilters.visible = _typevisible;
		}
		
		public function getFilters():Array 
		{
			return _listFilters;
		}
		
		
		
		
		private function onClickBtnBack(e:MouseEvent):void 
		{
			trace("onClickBtnBack");
			var _ascodemenu:ASCodeMenu = ASCodeMenu(ObjectSearch.getID("ascodemenu"));
			_ascodemenu.onClickBack();
		}
		
		public function set bgcolor(value:uint):void 
		{
			_bgcolor = value;
		}
		
		public function set typevisible(value:Boolean):void 
		{
			_typevisible = value;
		}
		
	}
	
}

