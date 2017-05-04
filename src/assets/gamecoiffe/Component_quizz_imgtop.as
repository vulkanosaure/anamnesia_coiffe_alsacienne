package assets.gamecoiffe 
{
	import data2.mvc.Component;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Vinc
	 */
	public class Component_quizz_imgtop extends Component
	{
		
		public function Component_quizz_imgtop() 
		{
			initComponent();
		}
		
		override public function initComponent():void 
		{
			super.initComponent();
			
			_bmp = new Bitmap();
			this.addChild(_bmp);
		}
		
	}

}