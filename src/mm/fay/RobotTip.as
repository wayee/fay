package mm.fay
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
	/**
	 * A robot tip can auto-remove itself for a while.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class RobotTip extends Sprite
	{
		private var _bg:DisplayObject;
		private var _tf:TextField;
		private var _offset:int = 4;
		
		public function RobotTip()
		{
			_tf = new TextField;
			_tf.multiline = true;
			_tf.wordWrap = true;
			_tf.textColor = 0xffffff;
			_tf.width = 200;
			_tf.x = _tf.y = _offset;
			addChild(_tf);
		}
		
		/**
		 * auto-remove itself 
		 */
		private function __onLaterHandler():void
		{
			if (parent) {
				parent.removeChild(this);
			}
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * show the tip content 
		 * @param text String tip text
		 * @param interval uint time(unit:secs)
		 * 
		 */
		public function show(text:String, pos:Point, interval:uint=5000, autoHide:Boolean=true):void
		{
			if (FayManager.getRoot()) {
				FayManager.getRoot().addChild(this);
				x = pos.x;
				y = pos.y;
				
				_tf.htmlText = text;
				
				if (autoHide) 
					setTimeout(__onLaterHandler, interval);
			}
		}
		
		public function setWidth(w:uint):void
		{
			width = w;
			_tf.width = w;
		}
		
		public function setHeight(h:uint):void
		{
			height = h;
			_tf.height = h;
		}
		
		public function setBackgroundChild(child:DisplayObject):void
		{
			if (child != _bg) {
				if (_bg) {
					removeChild(_bg);
				}
				_bg = child;
				if (child != null) {
					addChildAt(child, 0);
					_bg.width = _tf.width + _offset*2;
					_bg.height = _tf.height;
				}
			}
		}
	}
}