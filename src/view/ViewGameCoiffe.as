package view 
{
	import assets.gamecoiffe.Component_arianne;
	import assets.gamecoiffe.Component_solution_item;
	import data2.asxml.ObjectSearch;
	import data2.mvc.ViewBase;
	import data2.navigation.Navigation;
	import data2.navigation.NavigationDef;
	import data2.text.Text;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ViewGameCoiffe extends ViewBase
	{
		public static const NB_SOLUTION_MAX:int = 4;
		private static var _solutions:Array
		static private var _arianne:Component_arianne;
		
		public function ViewGameCoiffe() 
		{
			
		}
		
		
		
		public static function initQuestions(_nbquestions:int):void
		{
			_solutions = new Array();
			var _container:Sprite = getSprite("list_solutions_sub");
			
			for (var i:int = 0; i < NB_SOLUTION_MAX; i++) 
			{
				var _item:Component_solution_item = new Component_solution_item();
				_item.index = i;
				_solutions.push(_item);
				_item.y = i * 82;
				_item.initComponent();
				_container.addChild(_item);
				_item.onmousedown = "as:#ascodegamecoiffe  onClickSolution  " + i;
				_item.initOnClick(0);
			}
			
			_arianne = Component_arianne(ObjectSearch.getID("component_arianne"));
			_arianne.length = _nbquestions;		//todo dynamic
			var _containerarianne:Sprite = getSprite("question_filarianne");
			_containerarianne.x = Math.round(1080 * 0.5 - (_nbquestions - 1) * 37 * 0.5);
			
			_arianne.initComponent();
			
		}
		
		
		
		
		
		private static var _curstep:String;
		
		//quizz, answer, end
		public static function showStep(_idstep:String):void
		{
			if (_idstep != "end") {
				
				var _delayanswer:Number = (_idstep == "answer") ? 0.5 : 0.0;
				var _delayquizz:Number = (_idstep == "quizz") ? 0.5 : 0.0;
				
				if (_curstep == "end") {
					Navigation.animate("step_quizz_end", false, NavigationDef.DOWN, 0.0, 400, true, 0.3);
					Navigation.animate("step_quizz", true, NavigationDef.DOWN, 0.0, 400, true, 0.3);
				}
				else {
					Navigation.animateNoAnim("step_quizz_end", false);
					if (_idstep == "quizz") {
						
						Navigation.animate("zone_gamecoiffe_question", false, NavigationDef.DOWN, 0.0, 400, true, 0.3);
						Navigation.animate("zone_gamecoiffe_question", true, NavigationDef.DOWN, 0.35, 400, true, 0.3);
					}
				}
				
				Navigation.animate("zone_gamecoiffe_solution", (_idstep == "answer"), NavigationDef.DOWN, _delayanswer, 400, true, 0.3);
				Navigation.animate("list_solutions", (_idstep == "quizz"), NavigationDef.DOWN, _delayquizz, 400, true, 0.3);
				
			}
			else {
				Navigation.animate("step_quizz", false, NavigationDef.DOWN, 0.0, 400, true, 0.3);
				Navigation.animate("step_quizz_end", true, NavigationDef.DOWN, 0.5, 400, true, 0.3);
				
			}
			_curstep = _idstep;
		}
		
		
		
		
		
		static public function showHelpClick(boolean:Boolean):void 
		{
			getSprite("asset_gamecoiffe_helpclick").visible = boolean;
		}
		
		static public function resetArianne():void 
		{
			_arianne.reset();
		}
		
		static public function resetQuestions():void 
		{
			for (var i:int = 0; i < NB_SOLUTION_MAX; i++) 
			{
				var _item:Component_solution_item = Component_solution_item(_solutions[i]);
				_item.setSelected(false);
			}
		}
		
		static public function selectItem(_index:int, _value:Boolean):void
		{
			var _item:Component_solution_item = Component_solution_item(_solutions[_index]);
			_item.setSelected(_value);
		}
		
		static public function addArianne(_correct:Boolean):void 
		{
			_arianne.add(_correct);
			
		}
		
		static public function setResultTitle(_correct:Boolean):void 
		{
			getSprite("text_gamecoiffe_result_correct").visible = _correct;
			getSprite("text_gamecoiffe_result_wrong").visible = !_correct;
			
			getSprite("asset_gamecoiffe_valid").visible = _correct;
			getSprite("asset_gamecoiffe_wrong").visible = !_correct;
		}
		
		static public function onFooterResize(_text:Text):void 
		{
			trace("ViewGameCoiffe.onFooterResize");
			var _asset:Sprite = getSprite("asset_quizz_footer");
			_asset.x = 1080 * 0.5 - _text.getTextBounds().width * 0.5 - 85;
			_text.x = 1080 * 0.5 - _text.getTextBounds().width * 0.5;
			
		}
		
		static public function updateListQuestion(nbresponse:int):void 
		{
			for (var i:int = 0; i < NB_SOLUTION_MAX; i++) 
			{
				var _item:Component_solution_item = Component_solution_item(_solutions[i]);
				_item.visible = (i < nbresponse);
			}
		}
		
	}

}