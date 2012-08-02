package mm.fay.basic
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mm.fay.event.ReleaseEvent;
	import mm.fay.util.FUtil;
	import mm.fay.vo.IntRectangle;
	
	/**
	 * Fay Component based Sprite.
	 * <p>
	 * The Fay Component Assets structure:(Assets means flash player display objects)
	 * <pre>
	 *             | -- foreground decorator asset
	 *             |
	 *             |    [other assets, there is no depth restrict between them, see below ]
	 * FSprite  -- | -- [icon, border, ui creation, children component assets ...]          
	 *             |    [they are above background decorator and below foreground decorator]
	 *             |
	 *             | -- background decorator asset
	 * </pre>
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FSprite extends Sprite
	{
		protected var _foregroundChild:DisplayObject;
		protected var _backgroundChild:DisplayObject;
		
		protected var _pressedTarget:DisplayObject;
		
		private var _clipMasked:Boolean = false;
		private var _clipMaskRect:IntRectangle;
		private var _maskShape:Shape;
		
		public function FSprite(clipMasked:Boolean=false)
		{
			super();
			_clipMaskRect = new IntRectangle();
			setClipMasked(clipMasked);
			
			addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			super.addChild(child);
			
			if (_foregroundChild != null) {
				swapChildren(child, _foregroundChild);
			}
			
			return child;
		}
		
		/**
		 * Sets/gets the foreground child display object. 
		 */
		protected function getForegroundChild():DisplayObject
		{
			return _foregroundChild;
		}
		protected function setForegroundChild(child:DisplayObject):void
		{
			if (child != _foregroundChild) {
				if (_foregroundChild != null) {
					removeChild(_foregroundChild);
				}
				_foregroundChild = child;
				if (child != null) {
					addChild(child);
				}
			} 
		}
		
		/**
		 * Sets/gets the background child display object. 
		 */
		protected function getBackgroundChild():DisplayObject
		{
			return _backgroundChild;
		}
		protected function setBackgroundChild(child:DisplayObject):void
		{
			if (child != _backgroundChild) {
				if (_backgroundChild) {
					removeChild(_backgroundChild);
				}
				_backgroundChild = child;
				if (child != null) {
					addChildAt(child, 0);
				}
			}
		}
		
		/**
		 * Sets the mask shape rectangle. 
		 */
		protected function setClipMaskRect(b:IntRectangle):void
		{
			if (_maskShape) {
				_maskShape.x = b.x;
				_maskShape.y = b.y;
				_maskShape.height = b.height;
				_maskShape.width = b.width;
			}
			_clipMaskRect.setRect(b);
		}
		
		/**
		 * Checks whether the mask shape has been created.  
		 */
		private function checkCreateMaskShape():void
		{
			if (!_maskShape) {
				_maskShape = new Shape();
				_maskShape.graphics.beginFill(0);
				_maskShape.graphics.drawRect(0, 0, 1, 1);
				_maskShape.graphics.endFill();
			}
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Sets whether the component clip should be masked by its bounds. By default it is true.
		 */
		public function setClipMasked(m:Boolean):void
		{
			if (m != _clipMasked) {
				_clipMasked = m;
				if (_clipMasked) {
					checkCreateMaskShape();
					if (_maskShape.parent != this) {
						addChild(_maskShape);
						mask = _maskShape;
					}
					setClipMaskRect(_clipMaskRect);
				} else {
					if (_maskShape != null && _maskShape.parent == this) {
						removeChild(_maskShape);
					}
					mask = null;
				}
			}
		}
		
		/**
		 * Returns whether the component clip should be masked by its bounds. By default it is true.
		 */
		public function isClipMasked():Boolean
		{
			return _clipMasked;
		}
		
		/**
		 * Returns the current top index of a new child(none foreground child). 
		 */
		public function getHighestIndexUnderForeground():int
		{
			if (_foregroundChild == null) {
				return numChildren;
			} else {
				return numChildren - 1;
			}
		}
		
		/**
		 * Returns the current bottom for noen background child. 
		 */
		public function getLowestIndexAboveBackground():int
		{
			if (_backgroundChild == null) {
				return 0;
			} else {
				return 1;
			}
		}
		
		/**
		 * Returns the number of children except _foregroundChild, 
		 * _backgroundChild and  _maskShape
		 */		
		public function get countChildren():int
		{
			var num:int = numChildren;
			if (_foregroundChild != null) {
				num -= 1;
			}
			if (_backgroundChild != null) {
				num -= 1;
			}
			if (_maskShape != null) {
				num -= 1;
			}
			return num;
		}
		
		/**
		 * Brings a child to top. 
		 */
		public function bringToTop(child:DisplayObject):void
		{
			var index:int = numChildren - 1;
			if (_foregroundChild != null) {
				if (child != _foregroundChild) {
						index = numChildren - 2;
				}
			}
			setChildIndex(child, index);
		}
		
		/**
		 * Brings a child to bottom. 
		 */
		public function bringToBottom(child:DisplayObject):void
		{
			var index:int = 0;
			if (_backgroundChild != null) {
				if (child != _backgroundChild) {
					index = 1;
				}
			}
			setChildIndex(child, index);
		}
		
		override public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean=false):Boolean
		{
			if (isClipMasked() && !shapeFlag) {
				return _maskShape.hitTestPoint(x, y, shapeFlag);
			} else {
				return super.hitTestPoint(x, y, shapeFlag);
			}
		}
		
		override public function hitTestObject(obj:DisplayObject):Boolean
		{
			if (isClipMasked()) {
				return _maskShape.hitTestObject(obj);
			} else {
				return super.hitTestObject(obj);
			}
		}
		
		///////////////////////////////////
		// Event handlers
		///////////////////////////////////
		
		private function __onMouseDown(event:MouseEvent):void
		{
			_pressedTarget = event.target as DisplayObject;
			if (stage) {
				stage.addEventListener(MouseEvent.MOUSE_UP, __onStageMouseUp, false, 0, true);
				addEventListener(Event.REMOVED_FROM_STAGE, __onStageRemovedFrom);
			}
		}
		
		private function __onStageRemovedFrom(event:Event):void
		{
			_pressedTarget = null;
			stage.removeEventListener(MouseEvent.MOUSE_UP, __onStageMouseUp);
		}
		
		private function __onStageMouseUp(event:MouseEvent):void
		{
			if(stage) stage.removeEventListener(MouseEvent.MOUSE_UP, __onStageMouseUp);
			var isOutSide:Boolean = false;
			var target:DisplayObject = event.target as DisplayObject;
			if (!(this == target || FUtil.isAncestorDisplayObject(this, target))) {
				isOutSide = true;
			}
			dispatchEvent(new ReleaseEvent(ReleaseEvent.RELEASE, _pressedTarget, isOutSide, event));
			if (isOutSide) {
				dispatchEvent(new ReleaseEvent(ReleaseEvent.RELEASE_OUT_SIDE, _pressedTarget, isOutSide, event));
			}
			
			_pressedTarget = null;
		}
		
		/**
		 * Like Stage.mainPane.mainMenuPane.socialMenuItem
		 */
		override public function toString():String
		{
			var p:DisplayObject = this;
			var str:String = p.name;
			while (p.parent != null) {
				var name:String = (p.parent == p.stage ? 'Stage' : p.parent.name);
				p = p.parent;
				str = name + '.' + str;
			}
			return str;
		}
	}
}