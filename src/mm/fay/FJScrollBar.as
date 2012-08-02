package mm.fay
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mm.fay.basic.Component;
	import mm.fay.basic.FSprite;
	import mm.fay.event.ReleaseEvent;
	import mm.fay.laf.decorator.ScrollBarThumb;
	import mm.fay.util.FConst;
	import mm.fay.vo.IntPoint;

	/**
	 * 滚动条组件
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FJScrollBar extends Component
	{
		public static const HORIZONTAL:int = FConst.HORIZONTAL;
		public static const VERTICAL:int   = FConst.VERTICAL;
		
		protected var thumMC:FSprite;
		protected var thumbDecorator:ScrollBarThumb;
		protected var incrButton:FButton;
		protected var decrButton:FButton;
		protected var bg:Sprite;
		
		private var _value:int;
		private var _isDragging:Boolean;
		private var _offset:int;
		private var _orientation:Number;
		private var _unitIncrement:Number;
		private var _blockIncrement:Number;
		private var _scrollBarWidth:Number = 16;
		private var _minimumThumbLength:int;
		
		public function FJScrollBar(orientation:int=FConst.VERTICAL)
		{
			super();
			
			_orientation = orientation;	
			_unitIncrement = 1;
			_blockIncrement = 10;
			_minimumThumbLength = 9;
			_offset = 0;
			_isDragging = false;
			
			setSize(20, 200);
		}
		
		override public function getPropertyPrefix():String
		{
			return "ScrollBar.";
		}
		
		override protected function installDefaults():void
		{
			installColorAndFont();
			
			var pp:String = getPropertyPrefix();
			if (containsKey(pp + "barWidth")) {
				_scrollBarWidth = getInt(pp + "barWidth");
			}
			bg = getInstance(pp + "verticalBGImage");
			if (bg) addChild(bg);
		}
		
		override protected function installComponents():void
		{
			thumMC = new FSprite;
			var pp:String = getPropertyPrefix();
			thumbDecorator = getInstance(pp + "thumbDecorator");
			if (thumbDecorator != null) {
				if (thumbDecorator.getDisplay(this) != null) {
					thumMC.addChild(thumbDecorator.getDisplay(this));
				}
			}
			thumMC.y = _scrollBarWidth;
			addChild(thumMC);
			
			incrButton = createArrowButton();
			decrButton = createArrowButton();
			addChild(incrButton);
			addChild(decrButton);
		}

		override protected function uninstallComponents():void
		{
			removeChild(thumMC);
			removeChild(incrButton);
			removeChild(decrButton);
			
			thumbDecorator = null;
		}
		
		override protected function installListeners():void
		{
			thumMC.addEventListener(MouseEvent.MOUSE_DOWN, __onStartDragThumb);
			thumMC.addEventListener(ReleaseEvent.RELEASE, __onStopDragThumb);
			
			addEventListener(MouseEvent.MOUSE_WHEEL, __onMouseWheel);
		}
		override protected function uninstallListeners():void
		{
			thumMC.removeEventListener(MouseEvent.MOUSE_DOWN, __onStartDragThumb);
			thumMC.removeEventListener(ReleaseEvent.RELEASE, __onStopDragThumb);
		}
		
		/**
		 * 创建移动的箭头按钮 
		 * @return FButton
		 * 
		 */
		protected function createArrowButton():FButton
		{
			var b:FButton = new FButton();
			b.width = _scrollBarWidth;
			b.height = _scrollBarWidth;
			return b;
		}
		
		/**
		 * 开始拖动 
		 * @param event
		 * 
		 */
		private function __onStartDragThumb(event:MouseEvent):void
		{
			if (!isEnabled()) {
				return;
			}
			var mp:IntPoint = getMousePosition();
			_offset = mp.y - thumMC.y;
				
			_isDragging = true;
			_startHandleDrag();
		}
		
		/**
		 * 停止拖动 
		 * @param event
		 * 
		 */
		private function __onStopDragThumb(event:Event):void
		{
			_stopHandleDrag();
			if (!isEnabled()) {
				return;
			}
			if (_isDragging) {
				scrollThumbToCurrentMousePosition();
			}
			_isDragging = false;
		}
		
		/**
		 * 鼠标滚动 
		 * @param e
		 * 
		 */
		private function __onMouseWheel(event:MouseEvent):void
		{
			if (!isEnabled()) {
				return;
			}
			scrollByIncrement(-event.delta * getUnitIncrement());
		}
		
		/**
		 * 开始拖动后侦听鼠标移动事件 
		 * 
		 */
		private function _startHandleDrag():void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, __onMoveThumb, false, 0, true);
		}
		
		/**
		 *  停止拖动后移除事件侦听
		 * 
		 */
		private function _stopHandleDrag():void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, __onMoveThumb);
		}
		
		/**
		 * 鼠标移动事件 
		 * @param event
		 * 
		 */
		private function __onMoveThumb(event:MouseEvent):void
		{
			if (!isEnabled()) {
				return;
			}
			scrollThumbToCurrentMousePosition();
			event.updateAfterEvent();
		}
		
		/**
		 * 滚动滑块到鼠标的位置 
		 * 
		 */
		private function scrollThumbToCurrentMousePosition():void
		{
			var mp:IntPoint = getMousePosition();
			var thumbMin:int, thumbMax:int, thumbPos:int;
			thumbMin = decrButton.y + decrButton.height;
			thumbMax = incrButton.y - thumMC.height;
			thumbPos = Math.min(thumbMax, Math.max(thumbMin, mp.y - _offset));
			
			thumMC.y = thumbPos;
		}
		
		private function scrollByIncrement(increment:int):void
		{
			setValue(getValue() + increment);
		}
		
		override public function draw():void
		{
			super.draw();
			
			decrButton.y = 0;
			incrButton.y = _height - _scrollBarWidth;
			
			if (bg) {
				bg.width = _scrollBarWidth;
				bg.height = _height;
			}
			if (thumbDecorator) {
				thumbDecorator.updateDecorator(this, getDrawBounds());
			}
		}
		
		public function setValue(value:int):void
		{
			_value = value;
			
			var thumbMin:int, thumbMax:int, thumbPos:int;
			thumbMin = decrButton.y + decrButton.height;
			thumbMax = incrButton.y - thumMC.height;
			thumbPos = Math.min(thumbMax, Math.max(thumbMin, _value));
			
			thumMC.y = thumbPos;
		}
		public function getValue():int
		{
			return _value;
		}
		
		public function setUnitIncrement(unitIncrement:int):void
		{
			_unitIncrement = unitIncrement;
		}
		public function getUnitIncrement():int
		{
			return _unitIncrement;
		}
		
		public function getOrientation():Number
		{
			return _orientation;
		}
	}
}