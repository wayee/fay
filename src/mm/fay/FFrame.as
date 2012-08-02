package mm.fay
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mm.fay.basic.Container;
	import mm.fay.event.ReleaseEvent;
	import mm.fay.laf.IDecorator;
	import mm.fay.util.FUtil;
	import mm.fay.vo.IntDimension;
	import mm.fay.vo.IntRectangle;
	
	/**
	 * FFrame is a window with title state. 
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FFrame extends Container
	{
		public static const HIDE_ON_CLOSE:int = 1;
		public static const DISPOSE_ON_CLOSE:int = 2;
		
		private var _titleBar:FrameTitleBar;
		private var _closeButton:FButton;
		private var _contentPane:DisplayObjectContainer;
		private var _owner:DisplayObjectContainer;
		private var _text:String;
		
		protected var _ground_mc:Sprite;
		protected var _modalMC:Sprite;
		protected var _closeIcon:IDecorator;
		protected var _closable:Boolean;
		protected var _closeIconSize:IntDimension;
		protected var _defaultCloseOperation:int;
		protected var _modal:Boolean;
		
        public function FFrame(title:String='', modal:Boolean=false, owner:DisplayObjectContainer = null)
		{
			super();
			
			if (owner ==  null) {
				_owner = FayManager.getStage();
			} else if (owner is DisplayObjectContainer) {
				_owner = owner;
			} else {
				throw new TypeError(this + " FFrame's owner is not a DisplayObjectContainer, owner is : " + owner);
			}
			
			_text = title;
			_closable = true;
			_draggable = true;
			_defaultCloseOperation = HIDE_ON_CLOSE;
			_modal = modal;
			
        }
		
		override protected function installDefaults():void
		{
			var pp:String = getPropertyPrefix();
			
			_bgDecorator = getInstanceWithArgs(pp + "backgroundDecorator", [pp]);
			_closeIcon = getInstanceWithArgs(pp + 'closeIcon', ['Frame.closeIcon.']);
			_closeIconSize = new IntDimension(getInt(pp + 'closeIconWidth'), getInt(pp + 'closeIconHeight'));
			
			if (_bgDecorator) {
				setBackgroundChild(_bgDecorator.getDisplay(this));
			}
		}
		
		override protected function installComponents():void
		{
			_titleBar = new FrameTitleBar('', this);
			_contentPane = new Sprite;
			_closeButton = new FButton('');
			_closeButton.setBgDecorator(_closeIcon);
			_closeButton.setSize(_closeIconSize.width, _closeIconSize.height);
			
			_ground_mc = new Sprite;
			_ground_mc.visible = false;
			
			var groundRect:IntRectangle = FUtil.getVisibleMaximizedBounds(_ground_mc);
			
			_modalMC = new Sprite;
			initModalMC();
			
			_ground_mc.addChild(_modalMC);
			_ground_mc.addChild(this);
			
			addChild(_contentPane);
			addChild(_closeButton);
		}
		override protected function uninstallComponents():void
		{
			_owner.removeChild(_ground_mc);
			removeChild(_titleBar);
			removeChild(_contentPane);
			removeChild(_closeButton);
		}
		
		override protected function installListeners():void
		{
			_closeButton.addEventListener(MouseEvent.CLICK, __onCloseFrame);
			_titleBar.addEventListener(MouseEvent.MOUSE_DOWN, __onStartDragFrame);
			addEventListener(Event.ADDED_TO_STAGE, __onFrameAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, __onFrameRemoveToStage);
		}
		override protected function uninstallListeners():void
		{
			_closeButton.removeEventListener(MouseEvent.CLICK, __onCloseFrame);
			_titleBar.removeEventListener(MouseEvent.MOUSE_DOWN, __onStopDragFrame);
			removeEventListener(Event.ADDED_TO_STAGE, __onFrameAddToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, __onFrameRemoveToStage);
		}
		
		/**
		 * Resets the modal mc to cover the hole screen
		 */
		public function resetModalMC():void
		{
			if (!isModal()) {
				_modalMC.width = 0;
				_modalMC.height = 0;
				_modalMC.visible = false;
				return;
			}
			_modalMC.visible = true;
			var globalBounds:IntRectangle = FUtil.getVisibleMaximizedBounds(_ground_mc);
			_modalMC.width = globalBounds.width + 200;
			_modalMC.height = globalBounds.height + 200;
			_modalMC.x = globalBounds.x - 100;
			_modalMC.y = globalBounds.y - 100;
		}
		
		protected function initModalMC():void
		{
			_modalMC.tabEnabled = false;
			_modalMC.visible = _modal;
			_modalMC.graphics.clear();
			_modalMC.graphics.beginFill(0x000000, 0);
			_modalMC.graphics.drawRect(0, 0, 1, 1);
			_modalMC.graphics.endFill();
		}
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		protected function __onStartDragFrame(event:MouseEvent):void
		{
			if (isDraggable()) {
				this.startDrag();
				_titleBar.addEventListener(ReleaseEvent.RELEASE, __onStopDragFrame);
				_owner.addChild(this); // bring this to top
			}
		}

		protected function __onStopDragFrame(event:MouseEvent):void
		{
			this.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, __onStopDragFrame);
		}
		
		protected function __onCloseFrame(event:MouseEvent):void
		{
			if (_defaultCloseOperation == HIDE_ON_CLOSE) {
				hide();
			} else {
				dispose();
			}
		}
		
		private function __onFrameAddToStage(event:Event):void
		{
			stage.addEventListener(Event.RESIZE, __onResetModelMCWhenStageResized, false, 0, true);
		}
		private function __onFrameRemoveToStage(event:Event):void
		{
			stage.removeEventListener(Event.RESIZE, __onResetModelMCWhenStageResized, false);
		}

		private function __onResetModelMCWhenStageResized(event:Event):void
		{
			if (visible) {
				resetModalMC();
			}
		}

		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		override public function getPropertyPrefix():String
		{
			return "Frame.";
		}
		
		override public function draw():void
		{
			super.draw();
			
			if (_titleBar) {
				_titleBar.setSize(_width, 20);
				_titleBar.setText(_text);
			} 
			
			if (_contentPane) {
				_contentPane.y = _titleBar ? _titleBar.height : 0;
			} 
			_closeButton.visible = _closable;
			_closeButton.x = this.width - _closeButton.width;
			
			_bgDecorator && _bgDecorator.updateDecorator(this, getDrawBounds());
		}
		
		/**
		 * Show the Frame on stage. 
		 */
		public function show():void
		{
			visible = true;
		}
		
		/**
		 * Hide the Frame on stage. 
		 */
		public function hide():void
		{
			visible = false;
		}
		
		/**
		 * Hide the Frame on stage. 
		 */
		override public function dispose():void
		{
			super.dispose();
		}
		
		public function setContentPane(contentPane:DisplayObjectContainer):void
		{
			if (_contentPane != contentPane) {
				if (_contentPane == null) {
					throw new Error(this + " Can not set null to be FFrame's contentPane!");
				} else {
					if (_contentPane != null && _contentPane.parent) {
						_contentPane.parent.removeChild(_contentPane);
					}
					_contentPane = contentPane;
					if (_contentPane != null) {
						addChild(_contentPane);
					}
					invalidate();
				}
			}
		}
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Gets/sets the title shown in the title bar.
		 */
		public function setTitle(value:String):void
		{
			_text = value;
			_titleBar.setText(value);
		}
		public function getTitle():String
		{
			return _titleBar.getText();
		}
		
		public function setClosable(b:Boolean):void
		{
			if (_closable != b) {
				_closable = b;
				invalidate();
			}
		}
		
		/**
		 * Gets/sets the title bar. 
		 */
		public function getTitleBar():FrameTitleBar
		{
			return _titleBar;
		}
		public function setTitleBar(value:FrameTitleBar):void
		{
			if (_titleBar != null && _titleBar.parent) {
				removeChild(_titleBar);
				_titleBar.removeEventListener(MouseEvent.MOUSE_DOWN, __onStartDragFrame);
			}
			
			_titleBar = value;
			if (_titleBar != null) {
				addChild(_titleBar);
				_titleBar.addEventListener(MouseEvent.MOUSE_DOWN, __onStartDragFrame);
			}
			invalidate();
		}
		
		/**
		 * Sets whether or not the window will be draggable by the title bar. 
		 */		
		override public function setDraggable(b:Boolean):void
		{
			_draggable = b;
			_titleBar.buttonMode = b;
			_titleBar.useHandCursor = b;
		}
		
		/**
		 * Specifies whether this dialog should be modal.
		 */
		public function setModal(m:Boolean):void
		{
			if (_modal != m) {
				_modal = m;
				_modalMC.visible = _modal;
				resetModalMC();
			}
		}
		
		/**
		 * Returns is this dialog modal.
		 */
		public function isModal():Boolean
		{
			return _modal;
		}
		
		override public function set visible(b:Boolean):void
		{
			super.visible = b;
			_ground_mc.visible = b;
			
			if (b) {
				_owner.addChild(_ground_mc);
			}
			
			resetModalMC();
		}
    }
}