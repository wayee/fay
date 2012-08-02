package mm.fay
{
	import flash.display.DisplayObjectContainer;
	
	import mm.fay.basic.TextComponent;
	import mm.fay.laf.decorator.TextComponentBackground;

	/**
	 * A component that allows the editing of a single line of text.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FTextField extends TextComponent
	{
		private static var defaultMaxChars:int = 0;
		
		private var _textBg:TextComponentBackground;
		
		/**
		 * Constructor
		 * @param text String containing the label for this component.
		 * @param parent The parent DisplayObjectContainer on which to add this FTextField.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
        public function FTextField(text:String='', parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
			
			getTextField().multiline = false;
			getTextField().text = text;
			setMaxChars(defaultMaxChars);
			
			setSize(100, 20);
        }
		
		override public function getPropertyPrefix():String
		{
			return "TextField.";
		}
		
		public static function setDefaultMaxChars(n:int):void
		{
			defaultMaxChars = n;
		}
		public static function getDefaultMaxChars():int
		{
			return defaultMaxChars;
		}
    }
}