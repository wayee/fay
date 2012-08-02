package mm.fay.laf.decorator
{
	import flash.display.InteractiveObject;
	
	import mm.fay.basic.Component;
	import mm.fay.laf.IDecorator;
	import mm.fay.vo.IntRectangle;
	
	/**
	 * A basic background decorator.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class BasicBackground implements IDecorator
	{
		private var _bg:InteractiveObject;
		protected var _fixedPrefix:String;
		
		public function BasicBackground(fixedPrefix:String=null)
		{
			_fixedPrefix = fixedPrefix;
		}
		
		protected function getPropertyPrefix():String
		{
			if (_fixedPrefix != null) {
				return _fixedPrefix;
			}
			return "Component.";
		}
		
		/**
		 * Initializing the background object. 
		 */
		private function initBg():void
		{
			if (_bg) {
				_bg.mouseEnabled = false;
				_bg.tabEnabled = false;
			}
		}
		
		private function checkReloadAssets(c:Component):void
		{
			if (_bg) return;

			var pp:String = getPropertyPrefix();
			_bg = c.getInstance(pp + 'bgImage');
			initBg();
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public function setBackground(bg:InteractiveObject):void
		{
			_bg = bg;
			initBg();
		}
		
		public function updateDecorator(c:Component, r:IntRectangle=null):void
		{
			checkReloadAssets(c);
			
			if (r != null) {
				if (_bg) {
					_bg.width = r.width;
					_bg.height = r.height;
				}
				_bg.x = r.x;
				_bg.y = r.y;
			}
		}
		
		public function getDisplay(c:Component=null):InteractiveObject
		{
			checkReloadAssets(c);
			
			return _bg;
		}
	}
}