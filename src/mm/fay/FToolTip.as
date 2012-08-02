package mm.fay
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import mm.fay.basic.Component;
	import mm.fay.util.FUtil;
	import mm.fay.vo.Insets;
	import mm.fay.vo.IntDimension;

	/**
	 * A tooltip component.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FToolTip extends Component
	{
		private static const WAIT_TIME:int = 600;
		private static const FAST_OCCUR_TIME:int = 50;
		private static var last_tip_dropped_time:int = 0;
		
		protected var _textField:TextField;
		private var _tipText:String;
		private var _comp:InteractiveObject;
		private var _padding:Insets;
		private var _followMouse:Boolean;
		private var _rollover:Boolean;
		private var _containerRoot:DisplayObjectContainer;
		
		private var _timer:Timer;
		
        public function FToolTip()
		{
			super();
			
			_followMouse = true;
			
			_timer = new Timer(WAIT_TIME);
			_timer.addEventListener(TimerEvent.TIMER, __onTimerHandler);
        }

		override public function getPropertyPrefix():String
		{
			return "ToolTip.";
		}
		
		override protected function installDefaults():void
		{
			installColorAndFont();
			
			var pp:String = getPropertyPrefix();
			_padding = getInstance(pp + "padding");
			_bgDecorator = getInstanceWithArgs(pp + "backgroundDecorator", [pp]);
			
			if (_bgDecorator) {
				setBackgroundChild(_bgDecorator.getDisplay(this));
			}
			
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		override protected function installComponents():void
		{
			_textField = FUtil.createLabel(this, 'tooltip');
			_textField.multiline = true;
		}
		override protected function uninstallComponents():void
		{
			removeChild(_textField);
		}
		
		/**
		 * Move the tooltip to the Mouse position.
		 */
		private function position():void
		{
			var thisRoot:DisplayObjectContainer = getToolTipContainerRoot();
			var currentStage:Stage = getToolTipStage();
			var bounds:Rectangle = this.getBounds(this);
			if (thisRoot.mouseX + bounds.width > currentStage.stageWidth) {
				x = currentStage.stageWidth - bounds.width; 
			} else {
				x = thisRoot.mouseX + 10;
			}
			
			if (thisRoot.mouseY + bounds.height > currentStage.stageHeight) {
				y = currentStage.stageHeight - bounds.height;
			} else {
				y = thisRoot.mouseY + 20;
			}
		}
		
		/**
		 * View the tooltip in root.
		 */
		private function viewToolTip():void
		{
			var thisRoot:DisplayObjectContainer = getToolTipContainerRoot();
			if (thisRoot == null) {
				trace('root is null');
				return;
			}
			thisRoot.addChild(this);
			
			position();
		}
		
		private function getToolTipStage():Stage
		{
			if (getTargetComponent().stage == null) {
				return FayManager.getStage();
			}
			return getTargetComponent().stage;
		}
		
		private function getToolTipContainerRoot():DisplayObjectContainer
		{
			if (_containerRoot == null) {
				var thisRoot:DisplayObjectContainer = getTargetComponent().root as DisplayObjectContainer;
				if (thisRoot == null) {
					thisRoot = FayManager.getRoot();
				}
				return thisRoot;
			}
			return _containerRoot;
		}
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		protected function listenOwner(comp:InteractiveObject, useWeakReference:Boolean = false):void
		{
			comp.addEventListener(MouseEvent.ROLL_OVER, __onRollOver, false, 0, useWeakReference);
			comp.addEventListener(MouseEvent.ROLL_OUT, __onRollOut, false, 0, useWeakReference);
			comp.addEventListener(MouseEvent.MOUSE_DOWN, __onRollOut, false, 0, useWeakReference);
		}
		
		protected function unlistenOwner(comp:InteractiveObject):void
		{
			comp.removeEventListener(MouseEvent.ROLL_OVER, __onRollOver);
			comp.removeEventListener(MouseEvent.ROLL_OUT, __onRollOut);
			comp.removeEventListener(MouseEvent.MOUSE_DOWN, __onRollOut);
			//maybe showing, so this event need to remove
			comp.removeEventListener(MouseEvent.MOUSE_MOVE, __onMouseMoved);
		}
		
		private function __onRollOver(event:Event):void
		{
			var source:InteractiveObject = event.currentTarget as InteractiveObject;
			_compRollOver(source);
		}
		protected function _compRollOver(source:InteractiveObject):void
		{
			if (source == _comp) {
				startWaitToPopup();
			}
		}
		
		private function __onRollOut(event:Event):void
		{
			var source:InteractiveObject = event.currentTarget as InteractiveObject;
			_compRollOut(source);
		}
		protected function _compRollOut(source:InteractiveObject):void
		{
			if (source == _comp) {
				disposeToolTip();
			}
		}
		
		private function __onMouseMoved(event:Event):void
		{
			if (_followMouse) {
				position();
			}
		}
		
		private function __onTimerHandler(event:TimerEvent):void
		{
			_timer.stop();
			viewToolTip();
		}

		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		override public function draw():void
		{
			// Masking need the _width and _height
			_textField.htmlText = _tipText;
			_textField.y = _padding.left;
			_textField.x = _padding.top;
			var bounds:Rectangle = _textField.getBounds(this);
			var size:IntDimension = _padding.getOutsideSize(new IntDimension(bounds.width, bounds.height));
			_width = size.width;
			_height = size.height;
			
			super.draw();
			
			FUtil.applyTextFont(_textField, font);
			FUtil.applyTextColor(_textField, getForeground());
			
			if (_bgDecorator) {
				_bgDecorator.updateDecorator(this, getDrawBounds());
			}
		}
		
		/**
		 * Ready to popup the tooltip. 
		 */
		public function startWaitToPopup():void
		{
			if (getTimer() - last_tip_dropped_time < FAST_OCCUR_TIME) {
				_timer.delay = FAST_OCCUR_TIME;
			} else {
				_timer.delay = WAIT_TIME;
			}
			_timer.start();
			if (getTargetComponent()) {
				getTargetComponent().addEventListener(MouseEvent.MOUSE_MOVE, __onMouseMoved, false, 0, true);
			}
		}
		
		/**
		 * Close the tooltip.
		 */
		public function stopWaitToPopup():void
		{
			_timer.stop();
			if (getTargetComponent()){
				getTargetComponent().removeEventListener(MouseEvent.MOUSE_MOVE, __onMouseMoved);
			}
			last_tip_dropped_time = getTimer();
		}
		
		/**
		 * Dispose the tooltip.
		 */
		public function disposeToolTip():void
		{
			stopWaitToPopup();
			removeFromContainer();
		}
		
		/**
		 * Remove the tooltip from its parent.
		 */
		public function removeFromContainer():void
		{
			if (parent != null) {
				parent.removeChild(this);
			}
		}
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets/gets the shared tooltip target component. 
		 */
		public function setTargetComponent(c:InteractiveObject):void
		{
			if (c != _comp) {
				if (_comp != null) {
					unlistenOwner(_comp);
				}
				_comp = c;
				if (_comp != null) {
					listenOwner(_comp);
				}
			}
		}
		public function getTargetComponent():InteractiveObject
		{
			return _comp;
		}
		
		/**
		 * Sets/gets the tooltip text content.
		 */
		public function setTipText(t:String):void
		{
			if (t != _tipText) {
				_tipText = t;
				invalidate();
			}
		}
		public function getTipText():String
		{
			return _tipText;
		}
		
		/**
		 * Sets/gets the _followMouse property. 
		 */
		public function setFollowMouse(b:Boolean):void
		{
			_followMouse = b;
		}
		public function getFollowMouse():Boolean
		{
			return _followMouse;
		}
    }
}