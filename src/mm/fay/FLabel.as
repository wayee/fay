package mm.fay
{
	import flash.display.DisplayObjectContainer;
	import flash.filters.BlurFilter;
	import flash.text.TextField;
	
	import mm.fay.basic.Component;
	import mm.fay.util.FConst;
	import mm.fay.util.FUtil;
	import mm.fay.vo.IntRectangle;
	
	/**
	 * A Label component for displaying a single line of text.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FLabel extends Component
	{
		private static var viewRect:IntRectangle = new IntRectangle();
		private static var iconRect:IntRectangle = new IntRectangle();
		private static var textRect:IntRectangle = new IntRectangle();
		
		private var _text:String;
		
		private var selectable:Boolean;
		private var _textFilters:Array = null;
		
		protected var _textField:TextField;
		
		private var verticalAlignment:int;
		private var horizontalAlignment:int;
		private var verticalTextPosition:int;
		private var horizontalTextPosition:int;

		/**
		 * Constructor
		 * @param text String containing the label for this component.
		 * @param parent The parent DisplayObjectContainer on which to add this FLabel.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
        public function FLabel(text:String='', parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
			
			_text = text;
			verticalAlignment = FConst.CENTER;
			horizontalAlignment = FConst.CENTER;
			
			setSize(100, 20);
        }
		
		override public function getPropertyPrefix():String
		{
			return "Label.";
		}
		
		override protected function installDefaults():void
		{
			installColorAndFont();
			
			var pp:String = getPropertyPrefix();
			setTextFilters(getInstance(pp + "textFilters"));
			
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		override protected function installComponents():void
		{
			_textField = FUtil.createLabel(this, 'label');
		}
		override protected function uninstallComponents():void
		{
			removeChild(_textField);
		}
		
		override public function draw():void
		{
			super.draw();
			
			// 文本
			viewRect.setRect(getDrawBounds());
			textRect.x = textRect.y = textRect.width = textRect.height = 0;
			
			var text:String = FUtil.layoutCompoundLabel(this, 
				font, this.getText(), null, getVerticalAlignment(), 
				getHorizontalAlignment(), getVerticalTextPosition(), 
				getHorizontalTextPosition(), viewRect, iconRect, textRect);
			
			
			if (text != null && text != ""){
				_textField.visible = true;
				
				if(_textField.text != text){
					_textField.text = text;
				}
				
				FUtil.applyTextFont(_textField, font);
				FUtil.applyTextColor(_textField, getForeground());
				_textField.x = textRect.x;
				_textField.y = textRect.y;
				
				if (!isEnabled()) {
					filters = [new BlurFilter(2, 2, 2)];
				}else{
					filters = null;
				}
				_textField.filters = getTextFilters();
				
			}else{
				_textField.text = "";
				_textField.visible = false;
			}
			
			_textField.selectable = isSelectable();
			_textField.mouseEnabled = isSelectable();
		}
        
		public function setText(text:String):void
		{
			if (_text != text) {
				_text = text;
				invalidate();
			}
		}
		public function getText():String
		{
			return _text;
		}
		
		public function setSelectable(b:Boolean):void
		{
			selectable = b;
		}
		public function isSelectable():Boolean
		{
			return selectable;
		}
		
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
		 * 垂直方向齐 
		 */		
		public function getVerticalAlignment():Number
		{
			return verticalAlignment;
		}
		public function setVerticalAlignment(alignment:Number):void
		{
			if (alignment == verticalAlignment) {
				return;
			} else {
				verticalAlignment = alignment;
			}
		}
		
		/**
		 * 水平方向对齐 
		 */		
		public function getHorizontalAlignment():Number
		{
			return horizontalAlignment;
		}
		public function setHorizontalAlignment(alignment:Number):void
		{
			if (alignment == horizontalAlignment) {
				return;
			} else {
				horizontalAlignment = alignment;     
			}
		}
		
		public function getVerticalTextPosition():int
		{
			return verticalTextPosition;
		}
		public function setVerticalTextPosition(textPosition:int):void
		{
			if (textPosition == verticalTextPosition) {
				return;
			} else {
				verticalTextPosition = textPosition;
			}
		}
		
		public function getHorizontalTextPosition():int
		{
			return horizontalTextPosition;
		}
		public function setHorizontalTextPosition(textPosition:int):void
		{
			if (textPosition == horizontalTextPosition) {
				return;
			} else {
				horizontalTextPosition = textPosition;
			}
		}
    }
}