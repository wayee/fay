package mm.fay
{
	import flash.display.DisplayObjectContainer;
	
	import mm.fay.util.FConst;

	/**
	 * A basic radio button component, meant to be used in groups, where only one button in the group can be selected.
 	 * Currently only one group can be created.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FRadioButton extends FToggleButton
	{
		/**
		 * Constructor
		 * @param text String containing the label for this component.
		 * @param parent The parent DisplayObjectContainer on which to add this FRadioButton.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
        public function FRadioButton(text:String='', parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(text, parent, xpos, ypos);
			
			setHorizontalAlignment(FConst.LEFT);
			
        }
		
		override public function getPropertyPrefix():String
		{
			return "RadioButton.";
		}
    }
}