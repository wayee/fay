package mm.fay.basic
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import mm.fay.laf.decorator.TextComponentBackground;
	import mm.fay.util.FUtil;
	import mm.fay.vo.IntRectangle;
	
	/**
	 * TextComponent is the base class for text components.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class TextComponent extends Component
	{
		private var _textField:TextField;
		private var _editable:Boolean;
		
		private var _textBg:TextComponentBackground;
		
		/**
		 * Constructor
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param parent The parent DisplayObjectContainer on which to add this FTextComponent.
		 */
        public function TextComponent(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
        }
		
		override protected function installDefaults():void
		{
			installColorAndFont();
			
			var pp:String = getPropertyPrefix();
			_textBg = getInstance(pp + 'backgroundDecorator');
		}
		
		override protected function installComponents():void
		{
			_textField = new TextField;
			_textField.type = TextFieldType.INPUT;
			_textField.autoSize = TextFieldAutoSize.NONE;
			_textField.background = false;
			_editable = true;
			addChild(_textField);
		}
		override protected function uninstallComponents():void
		{
			removeChild(_textField);
		}
		
		override protected function installListeners():void
		{
			_textField.addEventListener(Event.CHANGE, __onChange);
			_textField.addEventListener(TextEvent.TEXT_INPUT, __onTextInput);
		}
		override protected function uninstallListeners():void
		{
			_textField.removeEventListener(Event.CHANGE, __onChange);
			_textField.removeEventListener(TextEvent.TEXT_INPUT, __onTextInput);
		}
		
		/**
		 * Aplly the bounds to the TextField display object.
		 */
		protected function applyBoundsToText(b:IntRectangle):void
		{
			var t:TextField = getTextField();
			t.x = b.x;
			t.y = b.y;
			t.width = b.width;
			t.height = b.height;
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		override public function getPropertyPrefix():String
		{
			return "TextComponent.";
		}
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			
			if (_textBg) {
				_textBg.updateDecorator(this, getDrawBounds());
				setBackgroundChild(_textBg.getDisplay(this));
			}
			
			FUtil.applyTextFont(getTextField(), font);
			FUtil.applyTextColor(getTextField(), getForeground());
			
			applyBoundsToText(getDrawBounds());
		}
		
		/**
		 * Gets the TextField display object. 
		 */
		public function getTextField():TextField
		{
			return _textField;
		}
		
		override public function setEnabled(b:Boolean):void
		{
			super.setEnabled(b);
			getTextField().selectable = b;
			getTextField().mouseEnabled = b;
		}
		
		/**
		 * Sets/gets the editable property. 
		 */
		public function setEditable(b:Boolean):void
		{
			if (b != _editable) {
				_editable = b;
				if (b) {
					getTextField().type = TextFieldType.INPUT;
				} else {
					getTextField().type = TextFieldType.DYNAMIC;
				}
				invalidate();
			}
		}
		public function isEditable():Boolean
		{
			return _editable;
		}
		
		/**
		 * Sets/gets the text content. 
		 */
		public function setText(text:String):void
		{
			if (getTextField().text != text) {
				getTextField().text = text;
			}
		}
		public function getText():String
		{
			return getTextField().text;
		}
		
		/**
		 * Sets/gets the html text content. 
		 */
		public function setHtmlText(text:String):void
		{
			if (getTextField().htmlText != text) {
				getTextField().htmlText = text;
			}
		}
		public function getHtmlText():String
		{
			return getTextField().htmlText;
		}
		
		public function appendText(newText:String):void
		{
			getTextField().appendText(newText);
		}
		
		public function replaceSelectedText(value:String):void
		{
			getTextField().replaceSelectedText(value);
		}
		
		public function replaceText(beginIndex:int, endIndex:int, newText:String):void
		{
			getTextField().replaceText(beginIndex, endIndex, newText);
		}
		
		public function setSelection(beginIndex:int, endIndex:int):void
		{
			getTextField().setSelection(beginIndex, endIndex);
		}
		
		public function selectAll():void
		{
			getTextField().setSelection(0, getTextField().length);
		}
		
		public function setDefaultTextFormat(dtf:TextFormat):void
		{
			getTextField().defaultTextFormat = dtf;
		}
		
		public function getDefaultTextFormat():TextFormat
		{
			return getTextField().defaultTextFormat;
		}
		
		public function setTextFormat(tf:TextFormat, beginIndex:int = -1, endIndex:int = -1):void
		{
			getTextField().setTextFormat(tf, beginIndex, endIndex);
		}
		
		public function getTextFormat(beginIndex:int = -1, endIndex:int = -1):TextFormat
		{
			return getTextField().getTextFormat(beginIndex, endIndex);
		}
		
		public function setDisplayAsPassword(b:Boolean):void
		{
			getTextField().displayAsPassword = b;
		}
		
		public function isDisplayAsPassword():Boolean
		{
			return getTextField().displayAsPassword;
		}
		
		public function getLength():int
		{
			return getTextField().length;
		}
		
		public function setMaxChars(n:int):void
		{
			getTextField().maxChars = n;
		}
		
		public function getMaxChars():int
		{
			return getTextField().maxChars;
		}
		
		public function setRestrict(res:String):void
		{
			getTextField().restrict = res;
		} 
		
		public function getRestrict():String
		{
			return getTextField().restrict;
		}
		
		public function setCSS(css:StyleSheet):void
		{
			getTextField().styleSheet = css;
		}
		
		public function getCSS():StyleSheet
		{
			return getTextField().styleSheet;
		}
		
		public function setWordWrap(b:Boolean):void
		{
			getTextField().wordWrap = b;
		}
		
		public function isWordWrap():Boolean
		{
			return getTextField().wordWrap;
		}
		
		///////////////////////////////////
		// Event handlers
		///////////////////////////////////
		
		private function __onTextInput(event:TextEvent):void
		{
			// fix the bug that fp in interenet browser single line TextField Ctrl+Enter will entered a newline bug
		}
		
		/**
		 * Called when the text in the text field is manually changed.
		 */
		protected function __onChange(event:Event):void
		{
			dispatchEvent(event);
		}
    }
}