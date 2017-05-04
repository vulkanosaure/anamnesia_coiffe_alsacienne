package model 
{
	import data2.asxml.Constantes;
	/**
	 * ...
	 * @author Vinc
	 */
	public class ModelQuizz 
	{
		
		public function ModelQuizz() 
		{
			
		}
		
		
		public static function getSomething():void
		{
			
			
			
		}
		
		static public function getNbQuestions():int 
		{
			var _tab:Array = Constantes.get("fr.quizz.questions.item") as Array;
			return _tab.length;
			
		}
		
		static public function getDataQuestion(_index:int):Object 
		{
			var _tab:Array = Constantes.get("fr.quizz.questions.item") as Array;
			return _tab[_index];
			
		}
		
		static public function getNbReponse(_data:Object):int
		{
			var _output:int = 0;
			var _tab:Object = _data["reponses"];
			if (_tab["reponse1"] != null) _output++;
			if (_tab["reponse2"] != null) _output++;
			if (_tab["reponse3"] != null) _output++;
			if (_tab["reponse4"] != null) _output++;
			if (_tab["reponse5"] != null) _output++;
			
			
			return _output;
		}
		
		
	}

}