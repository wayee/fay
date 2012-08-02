package mm.fay
{
	import mm.fay.basic.AbstractButton;
	import mm.fay.util.FUtil;

	/**
	 * This class is used to create a multiple-exclusion scope for a set of buttons. 
	 * Creating a set of buttons with the same FItemGroup object means that turning "on" 
	 * one of those buttons turns off all other buttons in the group. 
	 * <p>
	 * A FItemGroup can be used with any set of objects that inherit from AbstractButton. 
	 * Typically a button group contains instances of JRadioButton, JRadioButtonMenuItem, 
	 * or JToggleButton. It wouldn't make sense to put an instance of JButton or JMenuItem in a button group because JButton and JMenuItem don't implement the selected state. 
	 * </p>
	 * <p>
	 * Initially, all buttons in the group are unselected. Once any button is selected, one button is always selected in the group. There is no way to turn a button programmatically to "off", in order to clear the button group. To give the appearance of "none selected", add an invisible radio button to the group and then programmatically select that button to turn off all the displayed radio buttons. For example, a normal button with the label "none" could be wired to select the invisible radio button. 
	 * </p>
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FItemGroup
	{
		/**
		 * the list of buttons participating in this group
		 */
		protected var buttons:Array;
		
		private var allowUncheck : Boolean;
		
		/**
		 * The current selection.
		 */
		private var selection:AbstractButton = null;
		
		public function FItemGroup()
		{
			buttons = new Array();
		}
		
		/**
		 * Button group
		 */
		public static function groupButtons(...buttons):FItemGroup
		{
			var g:FItemGroup = new FItemGroup();
			for each (var i:AbstractButton in buttons) {
				g.append(i);
			}
			return g;
		}
		
		/**
		 * add to group
		 */ 
		public function append(b:AbstractButton):void
		{
			if (b == null) {
				return;
			}
			buttons.push(b);
			
			if (b.isSelected()) {
				if (selection == null) {
					selection = b;
				} else {
					b.setSelected(false);
				}
			}
			b.setGroup(this);
		}
		
		/**
		 * all add to group
		 */
		public function appendAll(...buttons):void
		{
			for each (var i:AbstractButton in buttons) {
				append(i);
			}
		}
		
		/**
		 * remove from group
		 */ 
		public function remove(b:AbstractButton):void {
			if (b == null) {
				return;
			}
			FUtil.removeFromArray(buttons, b);
			if (b == selection) {
				selection = null;
			}
			b.setGroup(null);
		}
		
		public function contains(b:AbstractButton):Boolean 
		{
			for (var i:Number=0; i<buttons.length; i++) {
				if (buttons[i] == b) {
					return true;
				}
			}
			return false;
		}
		
		public function getElements():Array 
		{
			return FUtil.cloneArray(buttons);
		}
		
		/**
		 * get the selected component
		 */
		public function getSelection():AbstractButton
		{
			return selection;
		}
		
		public function getSelectedIndex():int
		{
			for (var i : int = 0; i < buttons.length; i++) {
				if (AbstractButton(buttons[i]).isSelected()) return i;
			}
			return -1;
		}
		
		/**
		 * get selected button
		 */
		public function getSelectedButton():AbstractButton
		{
			for each (var b:AbstractButton in buttons) {
				if (b.isSelected()) {
					return b;
				}
			}
			return null;
		}
		
		/**
		 * set the status selected or not
		 */
		public function setSelected(button:AbstractButton, b:Boolean):void
		{
			if (b && button != null && button != selection) {
				var oldSelection:AbstractButton = selection;
				selection = button;
				if (oldSelection != null) {
					oldSelection.setSelected(false);
				}
				button.setSelected(true);
			}
			else if(!b && button != null && allowUncheck)
			{
				selection = null;
			}
		}
		
		/**
		 * Button is selected.
		 */
		public function isSelected(button:AbstractButton):Boolean
		{
			return (button == selection);
		}
		
		/**
		 * get the button count.
		 */
		public function getButtonCount():Number
		{
			return buttons.length;
		}
		
		/**
		 * get the first button. 
		 */		
		public function getItemByIndex(index:int):AbstractButton
		{
			if ( index < getButtonCount() && index >= 0 ) {
				return buttons[index];
			}
			return null;
		}
		
		/**
		 * set selected by index. 
		 */
		public function setSelectedByIndex(index:int):void
		{
			var b:AbstractButton = getItemByIndex(index);
			if (b) {
				setSelected(b, true);
			}
		}
		
		/**
		 * allow uncheck
		 */		
		public function setAllowUncheck(allowUncheck : Boolean) : void
		{
			this.allowUncheck = allowUncheck;
		}
	}
	
}