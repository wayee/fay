package mm.fay
{
	import flash.display.DisplayObjectContainer;
	
	import mm.fay.basic.Container;
	import mm.fay.util.FConst;
	
	/**
	 * A component that lets the user switch between a group of components by
 	 * clicking on a tab with a given title and/or icon.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FTabbedPane extends Container
	{
        private var _orientation:int;

		/**
		 * Constructor
		 * @param orientation Whether this is a vertical or horizontal FTabbedPane.
		 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
		 * @param parent The parent DisplayObjectContainer on which to add this FTabbedPane.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
        public function FTabbedPane(orientation:int=FConst.HORIZONTAL, parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);

			_orientation = orientation;
        }
		
		public function appendTab(pane:DisplayObjectContainer, label:String, tips:String=""):void
		{
			
		}
		
    }
}