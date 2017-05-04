package assets.gamecoiffe
{
	import data2.InterfaceSprite
	import data2.text.Text
	import flash.display.Sprite
	
	public class Component_question_arianne extends InterfaceSprite
	{
		private var _is0:Sprite;
		private var _is2:Sprite;
		private var _is4:Sprite;
		private var _is6:Sprite;
		static public const UNDONE:String = "undone";
		static public const DONE:String = "done";
		static public const VALID:String = "valid";
		static public const WRONG:String = "wrong";
		
		
		public function Component_question_arianne()
		{
			initComponent();
		}
		
		public function initComponent():void
		{
			_is0 = new asset_arianne_undone();
			this.addChild(_is0);
			_is0.x = -4.5; _is0.y = -4.5; 
			
			_is2 = new asset_arianne_done();
			this.addChild(_is2);
			_is2.x = -4.5; _is2.y = -4.5; 
			
			_is4 = new asset_arianne_error();
			this.addChild(_is4);
			_is4.x = -11; _is4.y = -11; 
			
			_is6 = new asset_arianne_valid();
			this.addChild(_is6);
			_is6.x = -11; _is6.y = -11; 
			
			
		}
		
		public function setState(_state:String):void 
		{
			_is0.visible = (_state == UNDONE);
			_is2.visible = (_state == DONE);
			_is4.visible = (_state == WRONG);
			_is6.visible = (_state == VALID);
		}
		
	}
	
}

