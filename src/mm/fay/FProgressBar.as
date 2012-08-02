package mm.fay
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import mm.fay.basic.Component;
	import mm.fay.util.Style;
	import mm.fay.vo.Insets;
	
	/**
	 * A progress bar component for showing a changing value in relation to a total.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FProgressBar extends Component
	{
		protected var _back:Sprite;
		protected var _bar:Sprite;
		protected var _value:Number = 0;
		protected var _max:Number = 1;
		protected var _padding:Insets;

		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this FProgressBar.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
		public function FProgressBar(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
			
			setSize(100, 10);
		}
		
		override public function getPropertyPrefix():String
		{
			return "ProgressBar.";
		}
		
		override protected function installDefaults():void
		{
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		override protected function installComponents():void
		{
			var pp:String = getPropertyPrefix();
			_back = getInstance(pp + 'horizotalBGImage');
			addChild(_back);
			
			_padding = getInstance(pp + 'padding');
			if (!_padding) _padding = new Insets;
			
			_bar = getInstance(pp + 'horizotalFGImage');
			_bar.x = _padding.left;
			_bar.y = _padding.top;
			addChild(_bar);
		}
		
		override protected function uninstallComponents():void
		{
			removeChild(_back);
			removeChild(_bar);
		}
		
		/**
		 * Updates the size of the progress bar based on the current value.
		 */
		protected function update():void
		{
			_bar.width = _bar.width * _value / _max;
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			_back.width = _width;
			_back.height = _height;
			
			_bar.width = _width - _padding.getMarginWidth();
			_bar.height = _height - _padding.getMarginHeight();
			
			update();
		}
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Gets / sets the maximum value of the ProgressBar.
		 */
		public function set maximum(m:Number):void
		{
			_max = m;
			_value = Math.min(_value, _max);
			update();
		}
		public function get maximum():Number
		{
			return _max;
		}
		
		/**
		 * Gets / sets the current value of the ProgressBar.
		 */
		public function set value(v:Number):void
		{
			_value = Math.min(v, _max);
			update();
		}
		public function get value():Number
		{
			return _value;
		}
		
	}
}