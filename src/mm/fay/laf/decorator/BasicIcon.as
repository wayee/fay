package mm.fay.laf.decorator
{
	import flash.display.InteractiveObject;
	
	import mm.fay.basic.Component;
	import mm.fay.laf.IDecorator;
	import mm.fay.laf.UIManager;
	import mm.fay.vo.IntRectangle;
	
	/**
	 * A basic icon decorator.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class BasicIcon implements IDecorator
	{
		private var _icon:InteractiveObject;
		protected var _fixedPrefix:String;
		
		public function BasicIcon(fixedPrefix:String=null)
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
		 * Initializing the icon object. 
		 */
		private function initIcon():void
		{
			if (_icon) {
				_icon.mouseEnabled = false;
				_icon.tabEnabled = false;
			}
		}
		
		private function checkReloadAssets(c:Component):void
		{
			if (_icon) return;
			
			var pp:String = getPropertyPrefix();
			_icon = c.getInstance(pp + 'iconImage');
			initIcon();
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public function setIcon(icon:InteractiveObject):void
		{
			_icon = icon;
		}
		
		public function updateDecorator(c:Component, r:IntRectangle=null):void
		{
			checkReloadAssets(c);
			
			if (r != null) {
				if (_icon) {
					_icon.width = r.width;
					_icon.height = r.height;
				}
				_icon.x = r.x;
				_icon.y = r.y;
			}
		}
		
		public function getDisplay(c:Component=null):InteractiveObject
		{
			checkReloadAssets(c);
			
			return _icon;
		}
	}
}