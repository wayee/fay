package mm.fay
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mm.fay.basic.TextComponent;
	
	/**
	 * A multi-line area that displays text.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FTextArea extends TextComponent
	{
		protected var _scrollbar:FVScrollBar;
		
		/**
		 * Constructor
		 * @param text String containing the label for this component.
		 * @param parent The parent DisplayObjectContainer on which to add this FTextArea.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
        public function FTextArea(text:String="", parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
			
			getTextField().multiline = true;
			getTextField().wordWrap = true;
			getTextField().text = text;
			
			setSize(100, 100);
        }
		
		override public function getPropertyPrefix():String
		{
			return "TextArea.";
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function installComponents():void
		{
			super.installComponents();
			_scrollbar = new FVScrollBar(onScrollbarScroll);
			addChild(_scrollbar);
		}
		override protected function uninstallComponents():void
		{
			removeChild(_scrollbar);
		}
		
		override protected function installListeners():void
		{
			addEventListener(MouseEvent.MOUSE_WHEEL, __onMouseWheel);
			getTextField().addEventListener(Event.SCROLL, onTextScroll);
		}
		override protected function uninstallListeners():void
		{
			removeEventListener(MouseEvent.MOUSE_WHEEL, __onMouseWheel);
			getTextField().removeEventListener(Event.SCROLL, onTextScroll);
		}
		
		/**
		 * Changes the thumb percent of the scrollbar based on how much text is shown in the text area.
		 */
		protected function updateScrollbar():void
		{
			var visibleLines:int = getTextField().numLines - getTextField().maxScrollV + 1;
			var percent:Number = visibleLines / getTextField().numLines;
			_scrollbar.setSliderParams(1, getTextField().maxScrollV, getTextField().scrollV);
			_scrollbar.setThumbPercent(percent);
			_scrollbar.pageSize = visibleLines;
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			
			getTextField().width = _width - _scrollbar.width - 4;
			_scrollbar.x = _width - _scrollbar.width;
			_scrollbar.height = _height;
			_scrollbar.draw();
			addEventListener(Event.ENTER_FRAME, __onTextScrollDelay);
		}
		
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Waits one more frame before updating scroll bar.
		 * It seems that numLines and maxScrollV are not valid immediately after changing a TextField's size.
		 */
		protected function __onTextScrollDelay(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, __onTextScrollDelay);
			updateScrollbar();
		}
		
		/**
		 * Called when the text in the text field is manually changed.
		 */
		protected override function __onChange(event:Event):void
		{
			super.__onChange(event);
			updateScrollbar();
		}
		
		/**
		 * Called when the scroll bar is moved. Scrolls text accordingly.
		 */
		protected function onScrollbarScroll(event:Event):void
		{
			getTextField().scrollV = Math.round(_scrollbar.value);
		}
		
		/**
		 * Called when the text is scrolled manually. Updates the position of the scroll bar.
		 */
		protected function onTextScroll(event:Event):void
		{
			_scrollbar.value = getTextField().scrollV;
			updateScrollbar();
		}

		/**
		 * Called when the mouse wheel is scrolled over the component.
		 */
		private function __onMouseWheel(event:MouseEvent):void
		{
			_scrollbar.value -= event.delta;
			getTextField().scrollV = Math.round(_scrollbar.value);
		}
		
		/**
		 * Sets/gets whether this component is enabled or not.
		 */
		public override function setEnabled(value:Boolean):void
		{
			super.setEnabled(value);
			getTextField().tabEnabled = value;
		}
		
		/**
		 * Sets / gets whether the scrollbar will auto hide when there is nothing to scroll.
		 */
		public function set autoHideScrollBar(value:Boolean):void
		{
			_scrollbar.autoHide = value;
		}
		public function get autoHideScrollBar():Boolean
		{
			return _scrollbar.autoHide;
		}
    }
}