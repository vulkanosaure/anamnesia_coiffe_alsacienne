package ascode 
{
	import data2.asxml.ASCode;
	import data2.asxml.ObjectSearch;
	import data2.navigation.Navigation;
	import model.translation.Translation;
	import view.ViewMenu;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ASCodeMenu extends ASCode
	{
		
		public function ASCodeMenu() 
		{
			
		}
		override public function exec():void 
		{
			ViewMenu.initDiapo();
			
			Navigation.addCallback("screen_menu", Navigation.CALLBACK_GOTO, onGotoMenu);
			Navigation.addCallback("screen_menu", Navigation.CALLBACK_QUIT, onQuitMenu);
		}
		
		
		
		public function onClickMenu(_idscreen:String):void
		{
			trace("onClickMenu(" + _idscreen + ")");
			if (Navigation.isLocked()) return;
			
			
			
			var _isIncontournable:Boolean = false;
			if (_idscreen == "screen_incontournables") {
				_isIncontournable = true;
				_idscreen = "screen_collection";
			}
			
			
			if (_idscreen == "screen_collection") {
				ASCodeCollection(ObjectSearch.getID("ascodecollection")).initScreen(_isIncontournable);
				if (_isIncontournable) {
					Translation.add("text_title_header", "header.incontournables.title", "MS900_36_FFFFFF");
					Translation.add("text_subtitle_header", "header.collection.subtitle", "MS500_19_FFFFFF");
					Translation.add("btn_detail_back_text", "header.incontournables.title", "MS900_36_B8AD9E");
				}
				else {
					Translation.add("text_title_header", "header.collection.title", "MS900_36_FFFFFF");
					Translation.add("text_subtitle_header", "header.collection.subtitle", "MS500_19_FFFFFF");
					Translation.add("btn_detail_back_text", "header.collection.title", "MS900_36_B8AD9E");
				}
			}
			else if (_idscreen == "screen_game_memory") {
				ASCodeGameMemory(ObjectSearch.getID("ascodegamememory")).initScreen();
				
				Translation.add("text_title_header", "header.game_memory.title", "MS900_36_FFFFFF");
				Translation.add("text_subtitle_header", "header.game_memory.subtitle", "MS500_19_FFFFFF");
			}
			else if (_idscreen == "screen_game_coiffe") {
				ASCodeGameCoiffe(ObjectSearch.getID("ascodegamecoiffe")).initScreen();
				
				Translation.add("text_title_header", "header.game_coiffe.title", "MS900_36_FFFFFF");
				Translation.add("text_subtitle_header", "header.game_coiffe.subtitle", "MS500_19_FFFFFF");
			}
			else if (_idscreen == "screen_game_compose") {
				ASCodeGameCompose(ObjectSearch.getID("ascodegamecompose")).initScreen();
				
				Translation.add("text_title_header", "header.game_compose.title", "MS900_36_FFFFFF");
				Translation.add("text_subtitle_header", "header.game_compose.subtitle", "MS500_19_FFFFFF");
			}
			else if (_idscreen == "screen_histoire") {
				ASCodeHistoire(ObjectSearch.getID("ascodehistoire")).initScreen();
				
				Translation.add("text_title_header", "header.histoire.title", "MS900_36_FFFFFF");
				Translation.add("text_subtitle_header", "header.histoire.subtitle", "MS500_19_FFFFFF");
			}
			else if (_idscreen == "screen_territoire") {
				ASCodeTerritoire(ObjectSearch.getID("ascodeterritoire")).initScreen();
				
				Translation.add("text_title_header", "header.territoire.title", "MS900_36_FFFFFF");
				Translation.add("text_subtitle_header", "header.territoire.subtitle", "MS500_19_FFFFFF");
			}
			
			Translation.translate("", ["text_title_header", "text_subtitle_header", "btn_detail_back_text"]);
			
			
			Navigation.gotoScreen(_idscreen);
			
			
		}
		
		public function onClickBack():void 
		{
			Navigation.gotoScreen("screen_menu");
		}
		
		
		private function onGotoMenu():void 
		{
			trace("onGotoMenu");
			ViewMenu.playDiapo(true);
			
			
		}
		
		private function onQuitMenu():void 
		{
			trace("onQuitMenu");
			ViewMenu.playDiapo(false);
		}
		
	}

}