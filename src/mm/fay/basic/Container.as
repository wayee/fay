package mm.fay.basic
{
	import flash.display.DisplayObjectContainer;
	
	import mm.fay.vo.Insets;

	/**
	 * Container can contain many component to be his child.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class Container extends Component
	{
		protected var _padding:Insets;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this FContainer.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
		public function Container(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public function get padding():Insets
		{ 
			return _padding;
		}
		public function set padding(value:Insets):void
		{
			_padding = value;
			invalidate();
		}
	}
}