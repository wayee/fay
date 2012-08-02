package mm.fay.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import mm.fay.util.FConst;
	import mm.fay.vo.Insets;
	import mm.fay.vo.IntGap;
	
	/**
	 * It ignores the width when set to Y_AXIS, ignores the hight when set to X_AXIS.
	 *  
	 * @example
	 * <listing version="3.0">
	 * var solidbox:SolidBoxUI = SolidBoxUI.create(stage);
	 * solidBox.setSize(400, 300)
	 * 			.setBackgroundColor(0xFF0000)
	 * 			.setBackgroundAlpha(0.2)
	 * 			.setGap(new IntGap(5, 5))
	 * 			.setPadding(new Insets(5, 5, 5, 5));
	 * 
	 * for (var i:int=0; i&lt;8; ++i) {
	 * 	var sprite:Sprite = new Sprite();
	 * 	sprite.graphics.beginFill(0xFF0000, .5);
	 * 	sprite.graphics.drawRect(0, 0, 100, 100);
	 * 	solidbox.addChild(sprite);
	 * }
	 * 
	 * solidbox.refresh();
	 * </listing>
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class SolidBoxUI extends LayoutUI
	{
		public static const X_AXIS:int = FConst.HORIZONTAL;
		public static const Y_AXIS:int = FConst.VERTICAL;
		
		private var _axis:int;
		
		public function SolidBoxUI(parent:DisplayObjectContainer=null, axis:int=X_AXIS)
		{
			super(parent);
			
			_axis = axis;
		}
		
		public static function create(parent:DisplayObjectContainer = null):SolidBoxUI
		{
			return new SolidBoxUI(parent);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			_childrenPadding = new Insets();
			_childrenGap = new IntGap();
		}
		
		override protected function update():void
		{
			var startX:Number = _childrenPadding.left;
			var startY:Number = _childrenPadding.top;

			var posX:Number = startX;
			var posY:Number = startY;
			var i:Number = 0;
			var l:Number = numChildren;
			var childWidth:Number = (_width - _childrenPadding.getMarginWidth() - _childrenGap.horizontal*(l-1))/l;
			var childHeight:Number = (_height - _childrenPadding.getMarginHeight() - _childrenGap.vertical*(l-1))/l;
			for (i; i<l; ++i) {
				var obj:DisplayObject = getChildAt(i);
				obj.x = posX;
				obj.y = posY;
				if (_axis == X_AXIS) {
					obj.width = childWidth;
					obj.height = _height - _childrenPadding.getMarginHeight();
					posX = obj.x + obj.width + _childrenGap.horizontal;
				} else {
					obj.width = _width - _childrenPadding.getMarginWidth();
					obj.height = childHeight;
					posY = obj.y + obj.height + _childrenGap.vertical;
				}
			}
			
			super.update();
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////

		/**
		 * Gets/sets the axis. 
		 */
		public function getAxis():int
		{
			return _axis;
		}
		public function setAxis(value:int):void
		{
			_axis = value;
		}

	}
}