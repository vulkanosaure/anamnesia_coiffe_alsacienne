package ascode 
{
	
	import data.display.FilledRectangle;
	import data.events.DynEvent;
	import data.fx.transitions.TweenManager;
	import data.utils.Delay;
	import data2.asxml.ASCode;
	import data2.asxml.ASXML;
	import data2.asxml.Constantes;
	import data2.asxml.ObjectSearch;
	import data2.asxml.Sessions;
	import data2.behaviours.Behaviour;
	import data2.display.Image;
	import data2.display.scrollbar.Scrollbar;
	import data2.dynamiclist.DynamicList;
	import data2.fx.delay.DelayManager;
	import data2.InterfaceSprite;
	import data2.math.Math2;
	import data2.navigation.Navigation;
	import data2.navigation.NavigationDef;
	import data2.net.URLLoaderManager;
	import data2.text.Text;
	import events.BroadCaster;
	import flash.display.BlendMode;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import model.translation.Translation;
	import timertouch.TimerTouch;
	import timertouch.TimerTouchEvent;
	import view.ViewCollection;
	import view.ViewCredits;
	import view.ViewGameCoiffe;
	import view.ViewGameMemory;
	import view.ViewHeader;
	import view.ViewHome;
	
	
	
	
	/**
	 * ...
	 * @author 
	 */
	dynamic public class ASCodeMain extends ASCode 
	{
		
		public function ASCodeMain() { } 
		
		
		override public function exec():void 
		{
			trace("ASCodeMain.exec");
			
			
			var _angle:Number = Math.atan2(255.5, 432);
			var _angledegre:Number = _angle * 180 / Math.PI;
			trace("_angledegre : " + _angledegre);
			
			if (Constantes.get("config.mouse_visible") == "0") Mouse.hide();
			
			
			
			//____________________________________________________________________________
			//navigation
			
			Navigation.addScreen("screen_home", [
				/*new NavigationDef("home_bg", NavigationDef.NONE, 0.5, 0, true),*/
				new NavigationDef("video_container", NavigationDef.NONE, 0.5, 0, true),
				new NavigationDef("home_zonecenter", NavigationDef.NONE, 0.5, 0, true),
			],
			[
				/*new NavigationDef("home_bg", NavigationDef.NONE, 0.0, 0, true),*/
				new NavigationDef("video_container", NavigationDef.NONE, 0.0, 0, true),
				new NavigationDef("home_zonecenter", NavigationDef.NONE, 0.0, 0, true),
			]);
			
			
			Navigation.addScreen("screen_menu", [
				new NavigationDef("btn_incontournables", NavigationDef.NONE, 0.0, 0, true),
				
				new NavigationDef("btn_collection", NavigationDef.LEFT, 0.15),
				new NavigationDef("btn_game_memory", NavigationDef.LEFT, 0.14),
				new NavigationDef("screen_menu_footer", NavigationDef.LEFT, 0.15),
				new NavigationDef("btn_histoire_coiffe", NavigationDef.RIGHT, 0.0),
				new NavigationDef("btn_notre_territoire", NavigationDef.RIGHT, 0.15),
				new NavigationDef("btn_game_compose", NavigationDef.RIGHT, 0.0),
				new NavigationDef("btn_game_coiffe", NavigationDef.RIGHT, 0.15),
			],
			[
				new NavigationDef("btn_incontournables", NavigationDef.NONE, 0.0, 0, true),
				
				new NavigationDef("btn_collection", NavigationDef.LEFT, 0.0),
				new NavigationDef("btn_game_memory", NavigationDef.LEFT, 0.0),
				new NavigationDef("screen_menu_footer", NavigationDef.LEFT, 0.0),
				new NavigationDef("btn_histoire_coiffe", NavigationDef.RIGHT, 0.0),
				new NavigationDef("btn_notre_territoire", NavigationDef.RIGHT, 0.0),
				new NavigationDef("btn_game_compose", NavigationDef.RIGHT, 0.0),
				new NavigationDef("btn_game_coiffe", NavigationDef.RIGHT, 0.0),
			]);
			Navigation.addScreen("screen_collection", [
				
				/*new NavigationDef("subheader_collection", NavigationDef.TOP, 0.15),*/
				new NavigationDef("list_articles", NavigationDef.NONE, 0.15, 0, true),
				new NavigationDef("collection_footer", NavigationDef.LEFT, 0.15),
				
			],
			[
				/*new NavigationDef("subheader_collection", NavigationDef.TOP, 0.1),*/
				new NavigationDef("list_articles", NavigationDef.NONE, 0.1, 0, true),
				new NavigationDef("collection_footer", NavigationDef.LEFT, 0.15),
			]);
			
			Navigation.addScreen("screen_histoire", [
				new NavigationDef("menu_histoire", NavigationDef.TOP, 0.15),
				new NavigationDef("histoire_bg", NavigationDef.NONE, 0.15, 0, true),
				new NavigationDef("histoire_container", NavigationDef.NONE, 0.15, 0, true),
			],
			[
				new NavigationDef("menu_histoire", NavigationDef.TOP, 0.15),
				new NavigationDef("histoire_bg", NavigationDef.NONE, 0.15, 0, true),
				new NavigationDef("histoire_container", NavigationDef.NONE, 0.15, 0, true),
			]);
			
			Navigation.addScreen("screen_territoire", [
				new NavigationDef("menu_territoire", NavigationDef.TOP, 0.15),
				new NavigationDef("territoire_bg", NavigationDef.NONE, 0.15, 0, true),
				new NavigationDef("territoire_container", NavigationDef.NONE, 0.15, 0, true),
			],
			[
				new NavigationDef("menu_territoire", NavigationDef.TOP, 0.15),
				new NavigationDef("territoire_bg", NavigationDef.NONE, 0.15, 0, true),
				new NavigationDef("territoire_container", NavigationDef.NONE, 0.15, 0, true),
			]);
			
			
			Navigation.addScreen("screen_game_memory", [
				new NavigationDef("asset_memory_bg", NavigationDef.NONE, 0.15, 0, true),
				new NavigationDef("screen_game_memory_content", NavigationDef.DOWN, 0.15, 600, true),
			],
			[
				new NavigationDef("screen_game_memory_content", NavigationDef.DOWN, 0.15, 600, true),
				new NavigationDef("asset_memory_bg", NavigationDef.NONE, 0.15, 0, true),
			]);
			
			Navigation.addScreen("screen_game_compose", [
				new NavigationDef("asset_bg_gamecompose", NavigationDef.NONE, 0.15, 0, true),
				new NavigationDef("gamecompose_content", NavigationDef.DOWN, 0.15, 600, true),
			],
			[
				new NavigationDef("gamecompose_content", NavigationDef.DOWN, 0.15, 600, true),
				new NavigationDef("asset_bg_gamecompose", NavigationDef.NONE, 0.15, 0, true),
			]);
			
			Navigation.addScreen("screen_game_coiffe", [
				new NavigationDef("asset_bg_gamecoiffe", NavigationDef.NONE, 0.15, 0, true),
				new NavigationDef("gamecoiffe_content", NavigationDef.DOWN, 0.15, 600, true),
			],
			[
				new NavigationDef("gamecoiffe_content", NavigationDef.DOWN, 0.15, 600, true),
				new NavigationDef("asset_bg_gamecoiffe", NavigationDef.NONE, 0.15, 0, true),
			]);
			
			
			Navigation.addScreen("screen_credits", [
				new NavigationDef("bg_popup", NavigationDef.NONE, 0.15, 0, true),
				new NavigationDef("credits_content", NavigationDef.DOWN, 0.15, 600, true),
			],
			[
				new NavigationDef("credits_content", NavigationDef.DOWN, 0.15, 600, true),
				new NavigationDef("bg_popup", NavigationDef.NONE, 0.15, 0, true),
			]);
			
			
			
			
			
			Navigation.addItem("header", null, ["screen_home"], 
				new NavigationDef("header", NavigationDef.TOP, 0.0, 400),
				new NavigationDef("header", NavigationDef.TOP, 0.0, 400)
			);
			Navigation.addItem("footer_bg", null, ["screen_home"], 
				new NavigationDef("footer_bg", NavigationDef.NONE, 0.0, 0, true),
				new NavigationDef("footer_bg", NavigationDef.NONE, 0.0, 0, true)
			);
			Navigation.addItem("subheader_collection", null, ["screen_home", "screen_menu", "screen_credits"], 
				new NavigationDef("subheader_collection", NavigationDef.TOP, 0.15),
				new NavigationDef("subheader_collection", NavigationDef.TOP, 0.1)
			);
			
			Navigation.addItem("footer_loghome", null, ["screen_game_memory", "screen_game_compose", "screen_game_coiffe"], 
				new NavigationDef("footer_loghome", NavigationDef.NONE, 0.05, 0, true),
				new NavigationDef("footer_loghome", NavigationDef.NONE, 0.05, 0, true)
			);
			
			
			
			Navigation.DEBUG = DataGlobal.DEBUG_NAVIGATION;
			Navigation.init("screen_home", _stage);
			//Navigation.init("screen_menu", _stage);
			
			
			
			Navigation.addClickableConflict("btn_fr", "home_zonecenter");
			Navigation.addClickableConflict("btn_en", "home_zonecenter");
			Navigation.addClickableConflict("btn_de", "home_zonecenter");
			
			Navigation.addClickableConflict("btn_collection");
			Navigation.addClickableConflict("btn_notre_territoire");
			Navigation.addClickableConflict("btn_histoire_coiffe");
			Navigation.addClickableConflict("btn_game_compose");
			Navigation.addClickableConflict("btn_game_coiffe");
			Navigation.addClickableConflict("btn_game_memory");
			Navigation.addClickableConflict("btn_incontournables");
			
			Navigation.addClickableConflict("header_btn_back");
			
			
			
			
			
			
			
			//____________________________________________________________________________
			//translation
			
			
			//menu / global
			Translation.add("header_title", "home.title", "MS900_50_FFFFFF");
			Translation.add("home_title", "home.title", "MS900_88_FFFFFF");
			Translation.add("home_subtitle", "home.subtitle", "MS500I_24_FFFFFF");
			Translation.add("btn_collection_text", "menu.collection", "MS900_42_FFFFFF");
			Translation.add("btn_notre_territoire_text", "menu.territoire", "MS900_36_FFFFFF_right");
			Translation.add("btn_histoire_coiffe_text", "menu.histoire", "MS900_36_FFFFFF_right");
			Translation.add("btn_game_compose_text", "menu.game_compose", "MS900_36_FFFFFF");
			Translation.add("btn_game_coiffe_text", "menu.game_coiffe", "MS900_36_FFFFFF_right");
			Translation.add("game_memory_text", "menu.game_memory", "MS900_36_FFFFFF");
			Translation.add("btn_incontournables_text", "menu.incontournables", "MS900_50_FFFFFF");
			
			
			//histoire
			for (var j:int = 0; j < DataGlobal.NB_PART_HISTOIRE; j++) 
			{
				Translation.addDynamic("text_histoire_" + j, "histoire.content.item", "text", "histoire_menuitem_text" + j, "");
				Translation.setDynamicIndex("text_histoire_" + j, j);
				
				Translation.addDynamic("histoire_menuitem_text" + j, "histoire.content.item", "menu_title", "histoire_menuitem_text" + j, "MS500_20_FFFFFF");
				Translation.setDynamicIndex("histoire_menuitem_text" + j, j);
			}
			Translation.add("scrollhandle_histoire_text", "histoire.scroll_help", "MS900_15_DEBUG");
			
			
			//territoire
			for (var j:int = 0; j < DataGlobal.NB_PART_TERRITOIRE; j++) 
			{
				Translation.addDynamic("text_territoire_" + j, "territoire.content.item", "text", "territoire_menuitem_text" + j, "");
				Translation.setDynamicIndex("text_territoire_" + j, j);
				
				Translation.addDynamic("territoire_menuitem_text" + j, "territoire.content.item", "menu_title", "territoire_menuitem_text" + j, "MS500_20_FFFFFF");
				Translation.setDynamicIndex("territoire_menuitem_text" + j, j);
			}
			Translation.add("scrollhandle_territoire_text", "histoire.scroll_help", "MS900_15_DEBUG");
			
			
			
			
			//collection
			Translation.addDynamic("detail_title_text", "collection.items.item", "texts.title", "index_article", "MS900_36_FFFFFF");
			Translation.addDynamic("detail_desc_text", "collection.items.item", "texts.desc", "index_article", "MS300_15_FFFFFF");
			Translation.addDynamic("detail_address_text", "collection.items.item", "texts.address", "index_article", "MS500_19_FFFFFF");
			Translation.addDynamic("detail_materiaux_text", "collection.items.item", "texts.materiau_desc", "index_article", "MS300_15_FFFFFF");
			Translation.addDynamic("legend_coiffe_text", "collection.items.item", "texts.legend", "index_article", "MS300_15_B8AD9E");
			
			Translation.addCallback("detail_desc_text", ViewCollection.onDescriptionChange);
			
			Translation.add("text_shortcut_collection", "menu.collection", "MS900_42_FFFFFF");
			Translation.add("text_help_details", "collection.help_detail", "MS700_15_B8AD9E", "text-align:right;");
			
			Translation.add("text_pagination_left", "collection.btn_page_prev", "MS900_20_FFFFFF", "text-align:right;");
			Translation.add("text_pagination_right", "collection.btn_page_next", "MS900_20_FFFFFF");
			
			Translation.add("detail_btn_navigation_left", "collection.btn_detail_prev", "MS900_15_B8AD9E");
			Translation.add("detail_btn_navigation_right", "collection.btn_detail_next", "MS900_15_B8AD9E", "text-align:right;");
			
			Translation.add("detail_btn_navigation_vignette_left", "collection.btn_vignette_prev", "MS900_15_B8AD9E");
			Translation.add("detail_btn_navigation_vignette_right", "collection.btn_vignette_next", "MS900_15_B8AD9E", "text-align:right;");
			
			Translation.add("text_btn_zoom", "collection.btn_zoom_in", "MS900_15_B8AD9E");
			Translation.add("text_btn_dezoom", "collection.btn_zoom_out", "MS900_15_B8AD9E");
			
			Translation.add("text_filter_1", "collection.filters.filter1", "MS900_15_FFFFFF", "text-align:center;");
			Translation.add("text_filter_2", "collection.filters.filter2", "MS900_15_FFFFFF", "text-align:center;");
			
			
			
			
			for (var j:int = 0; j < DataGlobal.NB_ARTICLE_PER_PAGE; j++) 
			{
				var _id:String = "text_collection_listing_" + j;
				Translation.addDynamic(_id, "collection.items.item", "texts.title", _id, "MS500_19_B8AD9E");
				Translation.setDynamicIndex(_id, j);
			}
			
			
			//quizz
			Translation.addDynamic("text_question_desc", "quizz.questions.item", "question", "index_quizz", "FRB_22_FFFFFF");
			Translation.addDynamic("text_gamecoiffe_result_desc", "quizz.questions.item", "explication", "index_quizz", "FRM_19_FFFFFF");
			
			for (var i:int = 0; i < ViewGameCoiffe.NB_SOLUTION_MAX; i++) 
			{
				Translation.addDynamic("quizz_solution_" + i, "quizz.questions.item", "reponses.reponse" + (i + 1), "index_quizz", "FRM_19_FFFFFF", true);
			}
			
			Translation.add("text_quizz_footer", "quizz.footer", "FRB_19_FFFFFF");
			Translation.add("text_gamecoiffe_result_correct", "quizz.good_answer", "FRB_36_FFFFFF");
			Translation.add("text_gamecoiffe_result_wrong", "quizz.wrong_answer", "FRB_36_FFFFFF");
			Translation.add("text_gamecoiffe_end_title", "quizz.title_end", "FRB_36_FFFFFF");
			Translation.add("text_quizz_restart", "quizz.btn_restart", "FREB_20_FFFFFF", "text-align:right;");
			Translation.add("text_compose_restart", "game_compose.btn_restart", "FREB_20_646475", "text-align:right;");
			Translation.add("text_quizz_next", "quizz.btn_next", "FREB_20_FFFFFF", "text-align:right;");
			Translation.add("text_gamecoiffe_end_desc", "quizz.desc_end", "FRM_19_FFFFFF", "text-align:right;");
			
			Translation.add("text_question_title", "quizz.title_question", "FREB_36_FFFFFF", "", false, true);
			Translation.addCallback("text_quizz_footer", ViewGameCoiffe.onFooterResize);
			
			
			//memory
			Translation.add("text_memory_footer", "memory.footer", "FRB_19_FFFFFF");
			Translation.add("text_restart_memory", "quizz.btn_restart", "FREB_20_FFFFFF");
			Translation.addCallback("text_memory_footer", ViewGameMemory.onFooterResize);
			Translation.addCallback("text_restart_memory", ViewGameMemory.onBtnRestartResize);
			
			//credits
			Translation.add("text_credits", "credits", "FREB_20_FFFFFF", "text-align:center;");
			Translation.add("text_close_credits", "global.btn_close", "MS900_15_FFFFFF", "text-align:center;");
			Translation.addCallback("text_credits", ViewCredits.onTextCreditsChange);
			
			//game compose
			Translation.add("text_gamecompose_consigne", "game_compose.consignes", "FRM_19_646475", "text-align:center;");
			Translation.add("text_btn_compose_right", "game_compose.next_step", "FREB_20_646475", "text-align:right;");
			Translation.add("text_btn_compose_left", "game_compose.prev_step", "FREB_20_646475", "text-align:left;");
			
			
			Translation.translate("fr", ["home_title", "home_subtitle"]);
			
			
			
			
			
		}
		
		
		
		
		
		public function func():void
		{
			
		}
		
		
		
		
		
		
		
	}
	
}