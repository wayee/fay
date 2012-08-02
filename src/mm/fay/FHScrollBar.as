package mm.fay
{
	import flash.display.DisplayObjectContainer;
	
	import mm.fay.util.FConst;
	
	/**
	 * A horizontal scroll bar for use in other components.
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FHScrollBar extends FScrollBar
	{
		/**
		 * Constructor
		 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
		 * @param parent The parent DisplayObjectContainer on which to add this FHScrollBar.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
		public function FHScrollBar(defaultHandler:Function=null, parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(FConst.HORIZONTAL, defaultHandler, parent, xpos, ypos);
		}
	}
}