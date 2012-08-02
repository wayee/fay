package mm.fay
{
	import flash.display.DisplayObjectContainer;
	
	import mm.fay.util.FConst;

	/**
	 * A basic CheckBox component.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FCheckBox extends FToggleButton
	{
		/**
		 * Constructor
		 * @param text String containing the label for this component.
		 * @param parent The parent DisplayObjectContainer on which to add this FCheckBox.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
        public function FCheckBox(text:String='', parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(text, parent, xpos, ypos);
			
			setHorizontalAlignment(FConst.LEFT);
        }
		
		override public function getPropertyPrefix():String
		{
			return "CheckBox.";
		}
    }
}