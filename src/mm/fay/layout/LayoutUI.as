package mm.fay.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import mm.fay.vo.Insets;
	import mm.fay.vo.IntGap;
	
	/**
	 * The LayoutUI class is a base for other layout classes (such as HBoxUI, VBoxUI, TileUI), but can be used as a basic container.
	 * 
	 * For example, for a LayoutUI instance with a width of 100, that has a children with a width that changes all the time (with a motion) from 100 to 300,
	 * The width value returned by the class will always be 100, while a normal DisplayObject class would return values between 100 and 300. 
	 * 
	 * @example
	 * <listing version="3.0">
	 * var layout:LayoutUI = LayoutUI.create(stage);
	 * layout.setSize(400, 300)
	 * 		 .setBackgroundColor(0xFF0000)
	 * 		 .setBackgroundAlpha(0.2)
	 * 		 .refresh();
	 * </listing>
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	
	public class LayoutUI extends Sprite
	{
		protected var _layouts:Array;
		protected var _width:Number;
		protected var _height:Number;
		protected var _backgroundColor:uint = 0;
		protected var _backgroundAlpha:Number = 0;
		protected var _hideOutsideContent:Boolean = false;
		
		protected var _childrenPadding:Insets;
		protected var _childrenGap:IntGap;
		protected var _childrenAlign:String;
		
		protected var _verticalAlign:int;
		protected var _horizontalAlign:int;
		
		/**
		 * Create a LayoutUI instance
		 * @param parent DisplayObjectContainer instance used to calculate the size and position of the layout instance
		 * @see #getRealWidth()
		 * @see #getRealHeight()
		 */
		public function LayoutUI(parent:DisplayObjectContainer = null)
		{
			if (parent != null) {
				parent.addChild(this);
			}
			initialize();
		}
		
		public static function create(parent:DisplayObjectContainer = null):LayoutUI
		{
			return new LayoutUI(parent);
		}
		
		protected function initialize():void
		{
			_layouts = []; 
			draw();
		}
		
		/**
		 * Marks the component to be redrawn on the next frame. 
		 */
		protected function invalidate():void
		{
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		/**
		 * Called one frame after invalidate is called. 
		 */
		private function onInvalidate(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
			update();
		}
		
		protected function onResize(event:Event):void
		{
			invalidate();
		}
		
		protected function draw():void
		{
			if (_backgroundAlpha <= 0) return;
			
			graphics.clear();
			graphics.beginFill(_backgroundColor, _backgroundAlpha);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			updateScrollRect();
		}
		
		protected function updateScrollRect():void
		{
			if (_hideOutsideContent) scrollRect = new Rectangle(0, 0, _width, _height);
			else scrollRect = null;
		}
		
		protected function refreshLayouts():void
		{
			if (_layouts == null) return;
			var i:Number = 0;
			var l:Number = _layouts.length;
			for (i; i<l; ++i) {
				LayoutUI(_layouts[i]).refresh();
			}
		}
		
		protected function removeLayout(layout:LayoutUI):void
		{
			var i:Number = 0;
			var l:Number = _layouts.length;
			for (i; i<l; ++i) {
				if (layout == _layouts[i]) _layouts.splice(i, 1);
			}
		}
		
		protected function setPrivateAlignment():void
		{
			var arr:Array = _childrenAlign.split("_");
			_horizontalAlign = int(arr[1]);
			_verticalAlign = int(arr[0]);
		}
		
		protected function update():void
		{
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Destroys the instance so it can be garbage collected. Automatically called when you remove an object from the BaseUI instance.
		 * @see mm.fay.BaseUI.remove()
		 * @see mm.fay.BaseUI.removeAll()
		 */
		public function dispose():void {
			// dispose objects, graphics and events listeners
			try {
				// dispose children
				while (numChildren > 0) {
					var child:DisplayObject = getChildAt(0);
					if (child != null && !(child is LayoutUI)) {
						if (child.hasOwnProperty("dispose")) child['dispose']();
						super.removeChildAt(0);
						child = null;
					}
				}
				// dispose layout
				if (_layouts != null) {
					while (_layouts.length > 0) {
						var layout:LayoutUI = _layouts[0];
						layout.dispose();
						super.removeChildAt(0);
						layout = null;
						_layouts.splice(0, 1);
					}
				}
				_layouts = null;
			} catch(e:Error) {
				trace("Error in", this, name, "(dispose method):", e.message);
			}
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if (child is LayoutUI) _layouts.push(child);
			child.addEventListener(Event.RESIZE, onResize);
			return super.addChild(child);
		}
		
		public function addChilds(...args):void
		{
			for each (var child:DisplayObject in args) {
				if (child) this.addChild(child);
			}
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			if (child is LayoutUI) _layouts.push(child);
			child.addEventListener(Event.RESIZE, onResize);
			return super.addChildAt(child, index);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			if (child is LayoutUI && _layouts.length > 0) removeLayout(LayoutUI(child));
			child.removeEventListener(Event.RESIZE, onResize);
			return super.removeChild(child);
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = getChildAt(index);
			if (child is LayoutUI && _layouts.length > 0) removeLayout(LayoutUI(child));
			child.removeEventListener(Event.RESIZE, onResize);
			return super.removeChildAt(index);
		}
		
		public function setSize(w:int, h:int):LayoutUI
		{
			_width = w;
			_height = h;
			invalidate();
			
			return this;
		}
		
		public function setLocation(xpos:int, ypos:int):LayoutUI
		{
			this.x = Math.round(xpos);
			this.y = Math.round(ypos);
			
			return this;
		}
		
		/**
		 * Background color of the layout instance
		 * @default 0x000000;
		 */
		public function getBackgroundColor():uint
		{
			return _backgroundColor;
		}
		
		public function setBackgroundColor(value:uint):LayoutUI
		{
			_backgroundColor = value;
			draw();
			return this;
		}
		
		/**
		 * Transparency of the layout instance background (alpha)
		 * @default 0;
		 */
		public function getBackgroundAlpha():Number
		{
			return _backgroundAlpha;
		}
		
		public function setBackgroundAlpha(value:Number):LayoutUI
		{
			_backgroundAlpha = value;
			draw();
			return this;
		}
		
		/**
		 * Hide the area of the DisplayObject children that are outside the boundaries (width and height)
		 * @default false;
		 */
		public function get hideOutsideContent():Boolean
		{
			return _hideOutsideContent;
		}
		
		public function set hideOutsideContent(value:Boolean):void
		{
			_hideOutsideContent = value;
			updateScrollRect();
		}
		
		/**
		 * Calculate and update the position and size of the layout
		 */
		public function refresh():void 
		{
			update();
			refreshLayouts();
		}
		
		/**
		 * Insets instance (Value Object) that contains the necessary properties to set the padding value in the layout (left, right, top, bottom).
		 * The padding is the distance between the DisplayObject children and the borders of the layout 
		 * @see mm.fay.vo.Insets
		 */
		public function getPadding():Insets
		{
			return _childrenPadding;
		}
		public function setPadding(value:Insets):LayoutUI
		{
			_childrenPadding = value;
			return this;
		}
		
		/**
		 * IntGap instance (Value Object) that contains the necessary properties to set the gap value between the DisplayObject children in the layout (horizontal, vertical).
		 * The gap is the distance between each one of the DisplayObject children, horizontally and vertically. 
		 * @see mm.fay.layout.vo.IntGap
		 */
		public function getGap():IntGap
		{
			return _childrenGap;
		}
		public function setGap(value:IntGap):LayoutUI
		{
			_childrenGap = value;
			return this;
		}
		
		/**
		 * Property to set the start position and direction of the alignment of the DisplayObject children in the layout. 
		 */
		public function getAlign():String
		{
			return _childrenAlign;
		}
		public function setAlign(value:String):LayoutUI
		{
			_childrenAlign = value;
			setPrivateAlignment();
			return this;
		}
		
		/**
		 * Get the real width of the layout
		 * @return A Number
		 */
		public function getRealWidth():Number
		{
			return super.width;
		}
		
		/**
		 * Get the real height of the layout
		 * @return A Number
		 */
		public function getRealHeight():Number
		{
			return super.height;
		}
		
		override public function set width(value:Number):void
		{
			_width = value;
			if (_width < 0) _width = 0;
			invalidate();
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set height(value:Number):void
		{
			_height = value;
			if (_height < 0) _height = 0;
			invalidate();
		}
		
		override public function get height():Number
		{
			return _height;
		}
	}
}