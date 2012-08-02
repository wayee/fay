 package mm.fay.layout {	import flash.display.DisplayObject;	import flash.display.DisplayObjectContainer;		import mm.fay.util.FConst;	import mm.fay.vo.Insets;	import mm.fay.vo.IntGap;
	/**	 * The VBoxUI class extends the LayoutUI class and works in the same way,	 * but it handles the position of its children by aligning them vertically in the box.	 * 	 * @example	 * <listing version="3.0">	 * var vbox:VBoxUI = VBoxUI.create(stage);	 * vbox.setSize(400, 300);	 * vbox.backgroundColor = 0xFF0000;	 * vbox.backgroundAlpha = 0.2;	 * vbox.childrenGap = new IntGap(5, 5);	 * vbox.childrenPadding = new Insets(5, 5, 5, 5);	 * vbox.childrenAlign = VBoxUI.ALIGN_BOTTOM_RIGHT;	 * 	 * for (var i:int=0; i&lt;8; ++i) {	 * 	var sprite:Sprite = new Sprite();	 * 	sprite.graphics.beginFill(0xFF0000, .5);	 * 	sprite.graphics.drawRect(0, 0, 100, 100);	 * 	vbox.addChild(sprite);	 * }	 * 	 * vbox.refresh();	 * </listing>	 * 	 * @author Andy Cai <huayicai@gmail.com>	 * 	 */		public class VBoxUI extends LayoutUI	{		public static const ALIGN_TOP_LEFT:String = FConst.ALIGN_TOP_LEFT;		public static const ALIGN_TOP_RIGHT:String = FConst.ALIGN_TOP_RIGHT;		public static const ALIGN_TOP_CENTER:String = FConst.ALIGN_TOP_CENTER;		public static const ALIGN_BOTTOM_LEFT:String = FConst.ALIGN_BOTTOM_LEFT;		public static const ALIGN_BOTTOM_RIGHT:String = FConst.ALIGN_BOTTOM_RIGHT;		public static const ALIGN_BOTTOM_CENTER:String = FConst.ALIGN_BOTTOM_CENTER;				protected const LEFT:int = FConst.LEFT;		protected const RIGHT:int = FConst.RIGHT;		protected const TOP:int = FConst.TOP;		protected const BOTTOM:int = FConst.BOTTOM;		protected const CENTER:int = FConst.CENTER;				/**		 * Create a VBoxUI instance		 * @param reference DisplayObjectContainer instance used to calculate the size and position of the layout instance		 */		public function VBoxUI(parent:DisplayObjectContainer = null)		{			super(parent);		}				public static function create(parent:DisplayObjectContainer = null):VBoxUI		{			return new VBoxUI(parent);		}				override protected function initialize():void		{			super.initialize();			_childrenPadding = new Insets();			_childrenGap = new IntGap();			_childrenAlign = ALIGN_TOP_LEFT;			setPrivateAlignment();//			_element.addEventListener(EventUI.UPDATED, updatedHandler);		}				/*protected function updatedHandler(e:EventUI):void		{			if (!_childrenEnable) return;			update();
		}*/				override protected function update():void		{			var startX:Number = 0;			var startY:Number = 0;			switch (_horizontalAlign) {				case LEFT:					startX = _childrenPadding.left;					break;				case CENTER:					startX = (_width>>1);					break;				case RIGHT:					startX = _width - _childrenPadding.right;					break;			}			switch (_verticalAlign) {				case TOP:					startY = _childrenPadding.top;					break;				case BOTTOM:					startY = _height - _childrenPadding.bottom;					break;			}			var posX:Number = startX;			var posY:Number = startY;			var i:Number = 0;			var l:Number = numChildren;			for (i; i<l; ++i) {				var obj:DisplayObject = getChildAt(i);				if (_horizontalAlign == CENTER) {					posX -= (obj.width>>1);				}				else if (_horizontalAlign == RIGHT) {					posX -= obj.width;				}				if (_verticalAlign == BOTTOM) {					posY -= obj.height;				}				obj.x = posX;				obj.y = posY;				posX = startX;				posY = (_verticalAlign == TOP) ? (obj.y + obj.height + _childrenGap.vertical) : (obj.y - _childrenGap.vertical);			}						super.update();		}						///////////////////////////////////		// public methods		///////////////////////////////////		override public function dispose():void 		{			// dispose objects, graphics and events listeners			try {//				if (_element != null) _element.removeEventListener(EventUI.UPDATED, updatedHandler);				_childrenPadding = null;				_childrenGap = null;				super.dispose();			} catch(e:Error) {				trace("Error in", this, "(dispose method):", e.message);			}		}				/**		 * Property to set the start position and direction of the alignment of the DisplayObject children in the layout. 		 * The value can be VBoxUI.ALIGN_TOP_LEFT, VBoxUI.ALIGN_TOP_CENTER, VBoxUI.ALIGN_TOP_RIGHT, VBoxUI.ALIGN_BOTTOM_LEFT, VBoxUI.ALIGN_BOTTOM_CENTER and VBoxUI.ALIGN_BOTTOM_RIGHT.		 */		override public function setAlign(value:String):LayoutUI		{			if (value != ALIGN_TOP_LEFT &&				value != ALIGN_TOP_CENTER &&				value != ALIGN_TOP_RIGHT &&				value != ALIGN_BOTTOM_LEFT &&				value != ALIGN_BOTTOM_CENTER &&				value != ALIGN_BOTTOM_RIGHT) {				throw new Error("Error in " + this + " (" + name + "): the align property must be, for example: VBoxUI.ALIGN_TOP_LEFT");			}			_childrenAlign = value;			setPrivateAlignment();			return this;		}	}}