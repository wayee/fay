package mm.fay.basic
{
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mm.fay.FItemGroup;
	import mm.fay.laf.IDecorator;
	import mm.fay.laf.decorator.BasicIcon;
	import mm.fay.laf.decorator.ButtonIcon;
	import mm.fay.laf.decorator.ButtonStateObject;
	import mm.fay.util.FConst;
	import mm.fay.util.FUtil;
	import mm.fay.vo.IntRectangle;

	/**
	 * Defines common behaviors for buttons.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class AbstractButton extends Component
	{
		private static var viewRect:IntRectangle = new IntRectangle();
		private static var iconRect:IntRectangle = new IntRectangle();
		private static var textRect:IntRectangle = new IntRectangle();
		
		protected var _group:FItemGroup;
		protected var _text:String;
		protected var _toggle:Boolean;
		protected var _rollOver:Boolean;
		protected var _pressed:Boolean;
		protected var _textFilters:Array;
		protected var _textField:TextField;
		
		private var verticalAlignment:int;
		private var horizontalAlignment:int;
		private var verticalTextPosition:int;
		private var horizontalTextPosition:int;
		
		protected var _buttonBg:ButtonStateObject;
		protected var _buttonIcon:ButtonIcon;
		protected var _iconTextGap:int = 4;
		
		/**
		 * Constructor
		 * @param text String containing the label for this component.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param parent The parent DisplayObjectContainer on which to add this FAbstractButton.
		 */
		public function AbstractButton(text:String='', parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);

			verticalAlignment = FConst.CENTER;
			horizontalAlignment = FConst.CENTER;
			verticalTextPosition = FConst.CENTER;
			horizontalTextPosition = FConst.RIGHT;
			
			_text = text;
			_toggle = false;
			_rollOver = false;
			_pressed = false;
		}

		override protected function installDefaults():void
		{
			installColorAndFont();
			
			var pp:String = getPropertyPrefix();
			setTextFilters(getInstance(pp + "textFilters"));
			
			_buttonBg = getInstanceWithArgs(pp + 'backgroundDecorator', [pp]);
			_buttonIcon = getInstanceWithArgs(pp + 'iconDecorator', [pp]);
			
			if (_buttonBg) setBackgroundChild(_buttonBg.getDisplay(this));
			if (_buttonIcon) addChild(_buttonIcon.getDisplay(this));
			
			buttonMode = true;
			mouseChildren = false;
		}
		
		override protected function installComponents():void
		{
			_textField = FUtil.createLabel(this, 'label');
		}
		override protected function uninstallComponents():void
		{
			removeChild(_textField);
		}
		
		override protected function installListeners():void
		{
			addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
			addEventListener(MouseEvent.ROLL_OVER, __onRollOver);
		}
		override protected function uninstallListeners():void
		{
			removeEventListener(MouseEvent.MOUSE_OVER, __onRollOver);
			removeEventListener(MouseEvent.MOUSE_OUT, __onMouseOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, __onMouseUp);
		}
		
		/**
		 * Updates the assets state.
		 */		
		private function updateState():void
		{
			if (_buttonBg) {
				_buttonBg.setEnabled(isEnabled());
				_buttonBg.setPressed(isPressed());
				_buttonBg.setRollovered(isRollOver());
				_buttonBg.setSelected(isSelected());
				_buttonBg.updateDecorator(this, getDrawBounds());
			}
			if (_buttonIcon) {
				_buttonIcon.setEnabled(isEnabled());
				_buttonIcon.setPressed(isPressed());
				_buttonIcon.setRollovered(isRollOver());
				_buttonIcon.setSelected(isSelected());
				_buttonIcon.updateDecorator(this);
			}
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		override public function getPropertyPrefix():String
		{
			return "AbstractButton.";
		}
		
		override public function draw():void
		{
			super.draw();
			
			updateState();
			
			// 文本
			viewRect.setRect(getDrawBounds());
			textRect.x = textRect.y = textRect.width = textRect.height = 0;
			iconRect.x = iconRect.y = iconRect.width = iconRect.height = 0;
			
			var text:String = FUtil.layoutCompoundLabel(this, 
				font, this.getText(), _buttonIcon, getVerticalAlignment(), 
				getHorizontalAlignment(), getVerticalTextPosition(), 
				getHorizontalTextPosition(), viewRect, iconRect, textRect,
				_iconTextGap);
			
			if (text != null && text != "") {
				_textField.visible = true;
				bringToTop(_textField);
				
				if (_textField.text != text) {
					_textField.text = text;
				}
				FUtil.applyTextFont(_textField, font);
				FUtil.applyTextColor(_textField, getForeground());
				_textField.x = textRect.x;
				_textField.y = textRect.y;
				_textField.filters = getTextFilters();
				
			} else {
				_textField.text = "";
				_textField.visible = false;
			}
			
			if (_buttonIcon) {
				_buttonIcon.getDisplay(this).x = iconRect.x;
				_buttonIcon.getDisplay(this).y = iconRect.y;
			}
		}
		
		/**
		 * Wrap a SimpleButton to be this button's representation.
		 * @param btn the SimpleButton to be wrap.
		 * @return the button self
		 */
		public function wrapSimpleButton(btn:SimpleButton):AbstractButton
		{
			mouseChildren = true;
			
			var icon:BasicIcon = new BasicIcon;
			icon.setIcon(btn);
			setIconDecorator(icon);
			setBgDecorator(null);
			
			return this;
		}
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function setBgDecorator(bg:IDecorator):void
		{
			_buttonBg = ButtonStateObject(bg);
			setBackgroundChild(_buttonBg ? _buttonBg.getDisplay(this) : null);
		}
		
		override public function setIconDecorator(icon:IDecorator):void
		{
			_buttonIcon = ButtonIcon(icon);
			invalidate();
		}
		
		/**
		 * Sets/gets the text filters.
		 */
		public function setTextFilters(fs:Array):void
		{
			_textFilters = fs;
			invalidate();
		}
		public function getTextFilters():Array
		{
			return _textFilters;
		}
		
		/**
		 * Sets/gets the text string.
		 */
		public function setText(text:String):void
		{
			if (this._text != text) {
				this._text = text;
				invalidate();
			}
		}
		public function getText():String
		{
			return _text;
		}
		
		/**
		 * Sets/gets the group of button.
		 */
		public function setGroup(group:FItemGroup):void
		{
			_group = group;
		}
		public function getGroup():FItemGroup
		{
			return _group;
		}
		
		/**
		 * Sets/gets the toggle state of button. 
		 */
		public function setToggle(b:Boolean):void
		{
			_toggle = b;
		}
		public function isToggle():Boolean
		{
			return _toggle;
		}
		
		/**
		 * Sets/gets the pressed state of button.
		 */
		public function setPressed(b:Boolean):void
		{
			if ((isPressed() == b) || !isEnabled()) {
				return;
			}
			_pressed = b;
		}
		public function isPressed():Boolean
		{
			return _pressed;
		}
		
		/**
		 * Sets/gets the _rollOver property.
		 */
		public function setRollOver(b:Boolean):void
		{
			if ((isRollOver() == b) || !isEnabled()) {
				return;
			}
			_rollOver = b;
		}
		public function isRollOver():Boolean
		{
			return _rollOver;
		}
		
		/**
		 * Sets/gets vertical alignment. 
		 */
		public function setVerticalAlignment(alignment:Number):void
		{
			if (alignment == verticalAlignment) {
				return;
			} else {
				verticalAlignment = alignment;
			}
		}
		public function getVerticalAlignment():Number
		{
			return verticalAlignment;
		}
		
		/**
		 * Sets/gets horizontal alignment. 
		 */
		public function setHorizontalAlignment(alignment:Number):void
		{
			if (alignment == horizontalAlignment) {
				return;
			} else {
				horizontalAlignment = alignment;     
			}
		}
		public function getHorizontalAlignment():Number
		{
			return horizontalAlignment;
		}
		
		/**
		 * Sets/gets vertical text position. 
		 */
		public function setVerticalTextPosition(textPosition:int):void
		{
			if (textPosition == verticalTextPosition) {
				return;
			} else {
				verticalTextPosition = textPosition;
			}
		}
		public function getVerticalTextPosition():int
		{
			return verticalTextPosition;
		}
		
		/**
		 * Sets/gets horizontal text position.
		 */
		public function setHorizontalTextPosition(textPosition:int):void
		{
			if (textPosition == horizontalTextPosition) {
				return;
			} else {
				horizontalTextPosition = textPosition;
			}
		}
		public function getHorizontalTextPosition():int
		{
			return horizontalTextPosition;
		}
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		protected function __onRollOver(event:MouseEvent):void
		{
			setRollOver(true);

			updateState();
			addEventListener(MouseEvent.ROLL_OUT, __onMouseOut);
		}
		
		protected function __onMouseOut(event:MouseEvent):void
		{
			setRollOver(false);

			updateState();
			removeEventListener(MouseEvent.ROLL_OUT, __onMouseOut);
		}
		
		protected function __onMouseDown(event:MouseEvent):void
		{
			setPressed(true);

			updateState();
			stage.addEventListener(MouseEvent.MOUSE_UP, __onMouseUp);
		}
		
		protected function __onMouseUp(event:MouseEvent):void
		{
			if (isToggle() && isRollOver()) {
				setSelected(!_selected);
			}
			setPressed(false);
			
			updateState();
			stage.removeEventListener(MouseEvent.MOUSE_UP, __onMouseUp);
		}
	}
}