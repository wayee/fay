package mm.fay
{
	import flash.display.DisplayObjectContainer;
	
	import mm.fay.basic.AbstractButton;

	/**
	 * An implementation of a two-state button.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FToggleButton extends AbstractButton
	{
		/**
		 * Constructor
		 * @param text String containing the label for this component.
		 * @param parent The parent DisplayObjectContainer on which to add this FToggleButton.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
        public function FToggleButton(text:String='', parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
            super(text, parent, xpos, ypos);
			
			setSize(100, 20);
			setToggle(true);
        }
		
		override public function getPropertyPrefix():String
		{
			return "ToggleButton.";
		}
		
		override public function setSelected(b:Boolean):void
		{
			var group:FItemGroup = getGroup();
			if (group != null) {
				// use the group model instead
				group.setSelected(this, b);
				b = group.isSelected(this);
			}
			super.setSelected(b);
		}
		
//		override public function setPressed(b:Boolean):void
//		{
//			if (isPressed()==b || !isEnabled()) {
//				return;
//			}
//			
//			if (b==false && isToggle()) {
//				setSelected(!isSelected());
//			}
//			
//			_pressed = b;
//		}
		
    }
}