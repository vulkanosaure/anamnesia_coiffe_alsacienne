package
{
	import ascode.ASCodeCollection;
	import ascode.ASCodeGameCoiffe;
	import ascode.ASCodeGameCompose;
	import ascode.ASCodeGameMemory;
	import ascode.ASCodeHistoire;
	import ascode.ASCodeHome;
	import ascode.ASCodeMain;
	import ascode.ASCodeMenu;
	import ascode.ASCodeTerritoire;
	import assets.collection.Component_article_listing;
	import assets.collection.Component_image_collection_big;
	import assets.collection.Component_vignette_big;
	import assets.collection.Component_vignette_small;
	import assets.Component_header;
	import assets.compose.Component_compose_choice;
	import assets.gamecoiffe.Component_arianne;
	import assets.gamecoiffe.Component_question_arianne;
	import assets.gamecoiffe.Component_quizz_imgtop;
	import assets.gamecoiffe.Component_solution_item;
	import assets.histoire.Component_histoire_menuitem;
	import assets.histoire.Component_scrollbar_handle;
	import assets.memory.Component_memory_item;
	import data.events.DynEvent;
	import data.utils.PositioningTool;
	import data2.asxml.Constantes;
	import data2.asxml.OnClickHandler;
	import data2.debug.InterfaceTrace;
	import data2.display.buttons.TouchButton;
	import data2.display.ClickableSprite;
	import flash.display.Loader;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import data.javascript.SWFAddress;
	import data.utils.Delay;
	import data2.asxml.ASXMLFileContent;
	import data2.asxml.ConstantesProvider;
	import data2.asxml.DynamicStateDef;
	import data2.behaviours.layout.GridLayout;
	import data2.behaviours.mousepointer.MousePointer;
	import data2.behaviours.videoplayer.VideoPlayer;
	import data2.debug.ASPannel;
	import data2.debug.ASXMLTracer;
	import data2.debug.DebugPannel;
	import data2.layoutengine.LayoutEngine;
	import data2.layoutengine.LayoutSprite;
	import data.abstrait.Document;
	import data.javascript.MacMouseWheel;
	import data2.asxml.ASXML;
	import data2.asxml.ObjectSearch;
	import data2.debug.RealTimeRefresh;
	import data2.asxml.Sessions;
	import data2.behaviours.form.Form;
	import data2.behaviours.layout.HLayout;
	import data2.behaviours.layout.ItemSlider;
	import data2.behaviours.layout.Spacer;
	import data2.behaviours.layout.VLayout;
	import data2.behaviours.menu.Menu;
	import data2.display.Image;
	import data2.display.scrollbar.Scrollbar;
	import data2.display.skins.Skin;
	import data2.effects.BGinEffect;
	import data2.effects.Effect;
	import data2.effects.FadeEffect;
	import data2.effects.MEffect;
	import data2.effects.RotationEffect;
	import data2.effects.SlideEffect;
	import data2.effects.SlideFadeEffect;
	import data2.effects.ToogleEffect;
	import data2.effects.ZoomEffect;
	import data2.InterfaceSprite;
	import data2.net.imageloader.ImageLoader;
	import data2.net.imageloader.ImageLoaderEvent;
	import data2.net.URLLoaderManager;
	import data2.display.skins.Skin;
	import data2.states.StateEngine;
	import data2.states.StateEvent;
	import data2.states.stateparser.StateParser;
	import data2.sound.SoundPlayer;
	import data2.text.Text;
	import data2.text.TextStylesheetConverter;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	import timertouch.TimerTouch;
	
	/**
	 * ...
	 * @author
	 */
	public class MainInterface extends MovieClip
	{
		public const INTERFACE_DIMS:Point = new Point(1920, 1080);
		
		public var SERVER_ENVIRONMENT:Boolean;
		public var DEBUG_MODE:Boolean;
		public var LOAD_IMG_INIT:Boolean = true;
		public var DEBUG_POSITION:Boolean;
		
		public function MainInterface()
		{
			
			Sessions.set("lang", "fr");
			
			var _flashvars:Object = this.loaderInfo.parameters;
			init();
		
		}
		
		private function init():void
		{
			trace("MainInterface.init");
			
			DEBUG_POSITION = DataGlobal.DEBUG_MODE;
			
			trace("this.parent : " + this.parent);
			ObjectSearch.flashvarsObject = this.loaderInfo.parameters;
			
			
			
			Font.registerFont(Font1);
			Font.registerFont(Font2);
			Font.registerFont(Font3);
			Font.registerFont(Font4);
			Font.registerFont(Font5);
			Font.registerFont(Font6);
			Font.registerFont(Font7);
			Font.registerFont(Font8);
			Font.registerFont(Font9);
			Font.registerFont(Font10);
			Font.registerFont(Font11);
			
			
			
			Text.DEFAULT_SELECTABLE = false;
			Text.DEFAULT_DEBUGBORDER = DEBUG_POSITION;
			ClickableSprite.DEBUG = DataGlobal.DEBUG_CLICKABLE;
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			trace("flashvars DEBUG_MODE : " + ObjectSearch.flashvars("DEBUG_MODE"));
			DEBUG_MODE = (ObjectSearch.flashvars("DEBUG_MODE") == "1");
			trace("DEBUG_MODE : " + DEBUG_MODE);
			
			MacMouseWheel.setup(stage);
			LayoutEngine.layoutSize = new Point(INTERFACE_DIMS.x, INTERFACE_DIMS.y);
			
			SERVER_ENVIRONMENT = (this.loaderInfo.url.search("http://") != -1);
			trace("SERVER_ENVIRONMENT : " + SERVER_ENVIRONMENT);
			
			var _nocache:Boolean = (DEBUG_MODE && SERVER_ENVIRONMENT);
			//trace("_nocache : " + _nocache);
			
			//URLLoaderManager.reset();
			URLLoaderManager.addEventListener(Event.COMPLETE, onURLLoaded);
			URLLoaderManager.load("interface-runtime/text.css", "stylesheet_text", _nocache);
			URLLoaderManager.load("interface-runtime/layout.css", "layout", _nocache);
			URLLoaderManager.load("interface-runtime/states.xml", "states", _nocache);
			URLLoaderManager.load("interface-runtime/effects.css", "effects", _nocache);
			URLLoaderManager.load("interface-runtime/main.xml", "asxml", _nocache);
			if (!SERVER_ENVIRONMENT)
				URLLoaderManager.load("interface-runtime/flashvars.xml", "flashvars", _nocache);
			
			if (DEBUG_MODE)
			{
				RealTimeRefresh.add("interface-runtime/text.css");
				RealTimeRefresh.add("interface-runtime/layout.css");
				RealTimeRefresh.add("interface-runtime/states.xml");
				RealTimeRefresh.add("interface-runtime/effects.css");
				RealTimeRefresh.add("interface-runtime/main.xml");
				RealTimeRefresh.init(SERVER_ENVIRONMENT, RealTimeRefresh.MODE_FOCUS, stage);
				
				
				DebugPannel.init(stage);
			}
			
			if (DEBUG_POSITION) {
				OnClickHandler.UPDATE_CLICKABLE = false;
				PositioningTool.init(stage);
			}
			
		
			//not generic
		
		}
		
		private function onURLLoaded(e:Event):void
		{
			URLLoaderManager.resetEventListeners();
			
			trace("MainInterface.onURLLoaded");
			
			//base
			ASXML.registerClass(Sprite);
			ASXML.registerClass(MovieClip);
			ASXML.registerClass(LayoutSprite);
			ASXML.registerClass(InterfaceSprite);
			ASXML.registerClass(TextField);
			//noyau
			ASXML.registerClass(DynamicStateDef);
			ASXML.registerClass(ConstantesProvider);
			ASXML.registerClass(ASXMLTracer);
			
			//display
			ASXML.registerClass(Image);
			ASXML.registerClass(Text);
			ASXML.registerClass(Skin);
			ASXML.registerClass(Scrollbar);
			ASXML.registerClass(TouchButton);
			
			//behaviours
			ASXML.registerClass(HLayout);
			ASXML.registerClass(VLayout);
			ASXML.registerClass(GridLayout);
			ASXML.registerClass(ItemSlider);
			ASXML.registerClass(Spacer);
			ASXML.registerClass(Form);
			ASXML.registerClass(Menu);
			ASXML.registerClass(MousePointer);
			ASXML.registerClass(VideoPlayer);
			//effects
			ASXML.registerClass(Effect);
			ASXML.registerClass(MEffect);
			ASXML.registerClass(FadeEffect);
			ASXML.registerClass(RotationEffect);
			ASXML.registerClass(SlideEffect);
			ASXML.registerClass(SlideFadeEffect);
			ASXML.registerClass(ZoomEffect);
			ASXML.registerClass(ToogleEffect);
			//sound
			ASXML.registerClass(SoundPlayer);
			
			//custom project
			ASXML.registerClass(Component_article_listing);
			ASXML.registerClass(Component_image_collection_big);
			ASXML.registerClass(Component_header);
			ASXML.registerClass(Component_vignette_big);
			ASXML.registerClass(Component_vignette_small);
			ASXML.registerClass(Component_histoire_menuitem);
			ASXML.registerClass(Component_scrollbar_handle);
			ASXML.registerClass(Component_memory_item);
			ASXML.registerClass(Component_solution_item);
			ASXML.registerClass(Component_question_arianne);
			ASXML.registerClass(Component_arianne);
			ASXML.registerClass(Component_compose_choice);
			ASXML.registerClass(Component_quizz_imgtop);
			
			//ascode
			ASXML.registerClass(ASCodeMain);
			ASXML.registerClass(ASCodeHome);
			ASXML.registerClass(ASCodeMenu);
			ASXML.registerClass(ASCodeCollection);
			ASXML.registerClass(ASCodeHistoire);
			ASXML.registerClass(ASCodeTerritoire);
			ASXML.registerClass(ASCodeGameCompose);
			ASXML.registerClass(ASCodeGameMemory);
			ASXML.registerClass(ASCodeGameCoiffe);
			
			//effects
			
			//flashvars default
			if (!SERVER_ENVIRONMENT)
				ObjectSearch.setDefaultFlashvars(URLLoaderManager.getXml("flashvars"));
			
			//text css conversion
			TextStylesheetConverter.init(URLLoaderManager.getStylesheet("stylesheet_text")); //stylesheet
			
			ASXML.addEventListener(Event.COMPLETE, onASXMLComplete);
			ASXML.init(URLLoaderManager.getData("asxml"), this, stage, DEBUG_MODE);
			
		
		}
		
		private function onASXMLComplete(e:Event):void
		{
			trace("onASXMLComplete");
			
			
			
			
			ASXML.removeEventListener(Event.COMPLETE, onASXMLComplete);
			
			if (LOAD_IMG_INIT)
			{
				ImageLoader.displayReports = false;
				ImageLoader.addEventListener(ImageLoaderEvent.COMPLETE, onImageLoaderComplete);
				ImageLoader.loadGroup(ImageLoader.GROUP_INIT);
					//ImageLoader.addEventListener(ImageLoaderEvent.PROGRESS, onImageLoaderProgress);
			}
			else
			{
				onImageLoaderComplete(null);
			}
		
		}
		
		private function onImageLoaderComplete(e:Event):void
		{
			
			trace("onImageLoaderComplete");
			//ImageLoader.resetEventListeners();
			ImageLoader.removeEventListener(ImageLoaderEvent.COMPLETE, onImageLoaderComplete);
			
			LayoutEngine.init(stage, this, null, URLLoaderManager.getData("layout"));
			ASXML.finalInitItem();
			ASXML.ascodeExec();
			LayoutEngine.start();
			
			StateParser.init(stage, this, URLLoaderManager.getXml("states"), URLLoaderManager.getData("effects"));
			StateParser.debug = DEBUG_MODE;
			
			ASXML.initItemBtnEffect();
			
			StateEngine.registerPropertySet();
			StateEngine.dispatchEvent(new StateEvent(StateEvent.COMPLETE));
			
			//devrait se faire plus tot dans l'idéal car si on fait bugger, pas de rechargement pour ces fichiers
			if (DEBUG_MODE)
			{
				var _importedFiles:Array = ASXML.importedFiles;
				for (var i:int = 0; i < _importedFiles.length; i++)
				{
					var _filename:String = ASXMLFileContent(_importedFiles[i]).name;
					//trace("_filename : " + _filename);
					RealTimeRefresh.add(_filename);
				}
				RealTimeRefresh.initDownload();
			}
			
			var _params:Object = this.loaderInfo.parameters;
			trace("______________\nparams");
			for (var name:String in _params)
			{
				trace("_params[" + name + "] : " + _params[name]);
			}
			
			
			
			//ImageLoader.loadGroup("thumbs");
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onkeydown);
			
			/*
			var _interfaceTrace:InterfaceTrace = new InterfaceTrace();
			_interfaceTrace.init(this);
			*/
			
		}
		
		private function onkeydown(e:KeyboardEvent):void
		{
		/*
		   trace("onkeydown");
		   if (e.keyCode == Keyboard.SPACE) {
		   resetLang("en");
		   }
		 */
		
		}
		
		/*_________________________________________________*/
		//shared function
		
		
	/*
	   public function displayTimerTouch():void
	   {
	   TimerTouch.show();
	   }
	   public function hideTimerTouch():void
	   {
	   TimerTouch.hide();
	   }
	 */
	
	}

}