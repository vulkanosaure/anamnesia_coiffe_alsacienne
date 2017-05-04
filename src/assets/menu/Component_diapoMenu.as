package assets.menu 
{
	import data.fx.transitions.SpriteTransitioner;
	import data.layout.slider.ItemSlider;
	import data2.asxml.Constantes;
	import data2.InterfaceSprite;
	import data2.net.imageloader.ImageLoader;
	import fl.transitions.easing.Regular;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Vinc
	 */
	public class Component_diapoMenu extends InterfaceSprite
	{
		private var _listurl:Array;
		private var _timer:Timer;
		//private var _slider:ItemSlider;
		private var _slider:SpriteTransitioner;
		
		public function Component_diapoMenu() 
		{
			
		}
		public function initComponent():void
		{
			/*
			_slider = new ItemSlider(1, 1080, 648, 1080, "horizontal");
			
			this.addChild(_slider);
			_slider.fade = false;
			*/
			
			
			
			
			_slider = new SpriteTransitioner();
			/*
			_slider.time_in = 0.7;
			_slider.time_out = 0.7;
			*/
			_slider.effect_in = Regular.easeIn;
			_slider.effect_in = Regular.easeOut;
			_slider.addTween("in", "x", +1080, 0, 0.9);
			_slider.addTween("out", "x", 0, -1080, 0.9);
			
			this.addChild(_slider);
			
			
			
			for (var i:int = 0; i < _listurl.length; i++) 
			{
				var _item:Component_diapoMenuItem = new Component_diapoMenuItem();
				_item.urlimg = _listurl[i];
				_item.initComponent();
				_item.updateComponent();
				_slider.addChild(_item);
				
			}
			ImageLoader.loadGroup();
			
			_slider.init(0);
			
			
			_timer = new Timer(Number(Constantes.get("config.time_anim_diapo")) * 1000);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
			
			
		}
		
		public function play():void
		{
			_timer.reset();
			_timer.start();
			
		}
		public function pause():void
		{
			_timer.stop();
		}
		
		
		private function onTimer(e:TimerEvent):void 
		{
			//trace("timerslide");
			_slider.next();
		}
		
		public function set listurl(value:Array):void 
		{
			_listurl = value;
		}
		
	}

}