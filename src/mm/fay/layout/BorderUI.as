package mm.fay.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import mm.fay.util.FConst;
	import mm.fay.vo.Insets;
	import mm.fay.vo.IntGap;
	
	/**
	 * A border layout lays out a container, arranging and resizing
	 * its components to fit in five regions:
	 * north, south, east, west, and center.
	 * Each region may contain no more than one component, and 
	 * is identified by a corresponding constant:
	 * <code>NORTH</code>, <code>SOUTH</code>, <code>EAST</code>,
	 * <code>WEST</code>, and <code>CENTER</code>.
	 *  
	 * @example
	 * <listing version="3.0">
	 * var border:BorderUI = BorderUI.create(stage);
	 * border.setSize(400, 400)
	 * 		 .backgroundColor(0xFF0000)
	 * 		 .backgroundAlpha(0.2)
	 * 		 .childrenGap(new IntGap(5, 5))
	 * 		 .childrenPadding(new Insets(5, 5, 5, 5));
	 * 
	 * var arrFun:Array = new Array(border.appendToEast, border.appendToWest, border.appendToSouth, border.appendToNorth, border.appendToCenter);
	 * 
	 * for (var i:int=0; i&lt;5; ++i) {
	 * 	var sprite:Sprite = new Sprite();
	 * 	sprite.graphics.beginFill(0xFF0000, .5);
	 * 	sprite.graphics.drawRect(0, 0, 100, 100);
	 * 	arrFun[i](sprite);
	 * }
	 * 
	 * border.refresh();
	 * </listing>
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class BorderUI extends LayoutUI
	{
		public static const EAST:int = FConst.EAST;
		public static const WEST:int = FConst.WEST;
		public static const SOUTH:int = FConst.SOUTH;
		public static const NORTH:int = FConst.NORTH;
		public static const CENTER:int = FConst.CENTER;
		
		private var _eastChild:Sprite;
		private var _westChild:Sprite;
		private var _southChild:Sprite;
		private var _northChild:Sprite;
		private var _centerChild:Sprite;
		
		public function BorderUI(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		public static function create(parent:DisplayObjectContainer = null):BorderUI
		{
			return new BorderUI(parent);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			_childrenPadding = new Insets();
			_childrenGap = new IntGap();
			
			_eastChild = new Sprite;
			addChild(_eastChild);
			_westChild = new Sprite;
			addChild(_westChild);
			_southChild = new Sprite;
			addChild(_southChild);
			_northChild = new Sprite;
			addChild(_northChild);
			_centerChild = new Sprite;
			addChild(_centerChild);
		}
		
		override protected function update():void
		{
			var eastWidth:Number = _eastChild.getBounds(_eastChild).width;
			var westWidth:Number = _westChild.getBounds(_westChild).width;
			var southHeight:Number = _southChild.getBounds(_southChild).height;
			var northHeight:Number = _northChild.getBounds(_northChild).height;
			
			_eastChild.x = _width - eastWidth - _childrenPadding.right;
			_eastChild.y = northHeight + _childrenPadding.top + _childrenGap.vertical;
			
			_westChild.x = _childrenPadding.left;
			_westChild.y = _eastChild.y
			
			_southChild.x = _westChild.x;
			_southChild.y = _height - southHeight - _childrenPadding.bottom;
			
			_northChild.x = _westChild.x;
			_northChild.y = _childrenPadding.top;

			_centerChild.x = _westChild.x + westWidth + _childrenGap.horizontal;
			_centerChild.y = _eastChild.y

			_northChild.width = _southChild.width = _width - _childrenPadding.getMarginWidth();
			_eastChild.height = _westChild.height = _centerChild.height = _height - northHeight - southHeight - _childrenGap.vertical*2 - _childrenPadding.getMarginHeight();
			_centerChild.width = _width - eastWidth - westWidth - _childrenGap.horizontal*2 - _childrenPadding.getMarginWidth();

			super.update();
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public function appendToEast(child:DisplayObject):BorderUI
		{
			_eastChild.addChild(child);
			return this;
		}

		public function appendToWest(child:DisplayObject):BorderUI
		{
			_westChild.addChild(child);
			return this;
		}

		public function appendToSouth(child:DisplayObject):BorderUI
		{
			_southChild.addChild(child);
			return this;
		}

		public function appendToNorth(child:DisplayObject):BorderUI
		{
			_northChild.addChild(child);
			return this;
		}

		public function appendToCenter(child:DisplayObject):BorderUI
		{
			_centerChild.addChild(child);
			return this;
		}
	}
}