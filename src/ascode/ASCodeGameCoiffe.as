package ascode 
{
	import assets.gamecoiffe.Component_quizz_imgtop;
	import data2.asxml.ASCode;
	import data2.asxml.ObjectSearch;
	import data2.fx.delay.DelayManager;
	import data2.net.imageloader.ImageLoader;
	import model.ModelQuizz;
	import model.translation.Translation;
	import view.ViewGameCoiffe;
	import view.ViewHeader;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ASCodeGameCoiffe extends ASCode
	{
		private var _locked:Boolean = true;
		private var _nbquestions:int;
		private var _indexQuestion:int;
		private var _dataQuestion:Object;
		
		public function ASCodeGameCoiffe() 
		{
			
		}
		
		
		override public function exec():void 
		{
			_nbquestions = ModelQuizz.getNbQuestions();
			ViewGameCoiffe.initQuestions(_nbquestions);
			
		}
		
		
		
		public function initScreen():void 
		{
			trace("ASCodeGameCoiffe.initScreen");
			
			trace("_nbquestions : " + _nbquestions);
			
			ViewHeader.updateHeader(0x79c1c9, false);
			
			initGame();
			
		}
		
		
		
		public function initGame():void
		{
			ViewGameCoiffe.showStep("quizz");
			ViewGameCoiffe.showHelpClick(true);
			ViewGameCoiffe.resetArianne();
			
			_indexQuestion = 0;
			loadQuestion(_indexQuestion);
			
			
			_locked = false;
		}
		
		
		
		private function loadQuestion(_index:int):void 
		{
			ViewGameCoiffe.resetQuestions();
			Translation.setDynamicIndex("index_quizz", _index);
			Translation.setContentVariable("index_question", String(_index + 1));
			
			var _filters:Array = ["text_question_desc", "text_question_title", "text_gamecoiffe_result_desc"];
			for (var i:int = 0; i < ViewGameCoiffe.NB_SOLUTION_MAX; i++) _filters.push("quizz_solution_" + i);
			
			try {
				Translation.translate("", _filters);
			}
			catch (e:Error) {
				trace("catch called");
			}
			
			_dataQuestion = ModelQuizz.getDataQuestion(_index);
			var _nbresponse:int = ModelQuizz.getNbReponse(_dataQuestion);
			trace("_nbresponse : " + _nbresponse);
			ViewGameCoiffe.updateListQuestion(_nbresponse);
			
			var _imgtop:Component_quizz_imgtop = Component_quizz_imgtop(ObjectSearch.getID("asset_gamecoiffe_imgtop"));
			_imgtop.urlimg = _dataQuestion.img;
			_imgtop.updateComponent();
			ImageLoader.loadGroup();
			
		}
		
		
		
		public function onClickSolution(_index:int):void
		{
			trace("onClickSolution(" + _index + ")");
			
			if (_locked) return;
			_locked = true;
			
			ViewGameCoiffe.showHelpClick(false);
			
			var _correct:Boolean = (_index == int(_dataQuestion.correct) - 1);
			trace("_correct : " + _correct);
			var _end:Boolean = _indexQuestion == _nbquestions - 1;
			
			ViewGameCoiffe.selectItem(_index, true);
			
			DelayManager.add("", 800, function():void {
				
				ViewGameCoiffe.setResultTitle(_correct);
				if (_correct) {
					
				}
				else {
					
				}
				ViewGameCoiffe.addArianne(_correct);
				ViewGameCoiffe.showStep("answer");
				
			});
			
			_indexQuestion++;
			
		}
		
		
		public function onClickNext():void
		{
			
			if (_indexQuestion < _nbquestions) {
				
				//load content
				loadQuestion(_indexQuestion);
				
				ViewGameCoiffe.showStep("quizz");
				_locked = false;
			}
			else ViewGameCoiffe.showStep("end");
			
		}
		
		
		public function onClickRestart():void
		{
			initGame();
			
		}
		
		
	}

}