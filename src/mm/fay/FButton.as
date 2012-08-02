package mm.fay
{
	import flash.display.DisplayObjectContainer;
	
	import mm.fay.basic.AbstractButton;

	/**
	 * A button components.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FButton extends AbstractButton
	{
		/**
		 * Constructor
		 * @param text String containing the label for this component.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param parent The parent DisplayObjectContainer on which to add this FButton.
		 */
        public function FButton(text:String='', parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
            super(text, parent, xpos, ypos);
			
			setSize(100, 20);
        }
		
		override public function getPropertyPrefix():String
		{
			return "Button.";
		}
		
    }
}