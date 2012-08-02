package mm.fay
{
	import flash.display.DisplayObjectContainer;
	
	import mm.fay.util.FConst;

	/**
	 * A Horizontal Slider component for choosing values.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FHSlider extends FSlider
	{
		/**
		 * Constructor
		 * @param defaultHandler The event handling function to handle the default event for this component.
		 * @param parent The parent DisplayObjectContainer on which to add this FHSlider.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
		public function FHSlider(defaultHandler:Function = null, parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(FConst.HORIZONTAL, defaultHandler, parent, xpos, ypos);
		}
	}
}
