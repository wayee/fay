package mm.fay
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import mm.fay.basic.Container;
	
	/**
	 * A Panel component is just a simple container.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FPanel extends Container
	{
		private var _content:Sprite;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this FCanvas.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
		public function FPanel(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
			
			_content = new Sprite;
			super.addChild(_content);
			
			setSize(100, 100);
		}
		
		override protected function installDefaults():void
		{
			var pp:String = getPropertyPrefix();
			
			_bgDecorator = getInstanceWithArgs(pp + "backgroundDecorator", [pp]);
			_padding = getInstance(pp + "padding");
			
			if (_bgDecorator) {
				setBackgroundChild(_bgDecorator.getDisplay(this));
			}
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		override public function getPropertyPrefix():String
		{
			return "Panel.";
		}
		
		override public function draw():void
		{
			super.draw();
			
			if (_padding) {
				_content.x = _padding.left;
				_content.y = _padding.top;
			}
			
			if (_bgDecorator) {
				_bgDecorator.updateDecorator(this, getDrawBounds());
			}
		}
		
		public function get content():Sprite
		{
			return _content;
		}
		public function set content(value:Sprite):void
		{
			_content = value;
		}
		
	}
}