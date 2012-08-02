package mm.fay.util
{
	/**
	 * All the constants of all the components.
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FConst
	{
		public static const NONE:int = -1;
		
		/** 
		 * The central position in an area. Used for
		 * both compass-direction constants (NORTH, etc.)
		 * and box-orientation constants (TOP, etc.).
		 */
		public static const CENTER:int  = 0;
		
		
		///////////////////////////////////
		// Box-orientation constants
		///////////////////////////////////

		/** 
		 * Box-orientation constant used to specify the top of a box.
		 */
		public static const TOP:int     = 1;
		/** 
		 * Box-orientation constant used to specify the left side of a box.
		 */
		public static const RIGHT:int    = 2;
		/** 
		 * Box-orientation constant used to specify the bottom of a box.
		 */
		public static const BOTTOM:int  = 3;
		/** 
		 * Box-orientation constant used to specify the right side of a box.
		 */
		public static const LEFT:int   = 4;
		
		
		///////////////////////////////////
		// Compass-dirction constants
		///////////////////////////////////

		/** 
		 * Compass-direction North (up).
		 */
		public static const NORTH:int      = 1;
		/** 
		 * Compass-direction north-east (upper right).
		 */
		public static const NORTH_EAST:int = 2;
		/** 
		 * Compass-direction east (right).
		 */
		public static const EAST:int       = 3;
		/** 
		 * Compass-direction south-east (lower right).
		 */
		public static const SOUTH_EAST:int = 4;
		/** 
		 * Compass-direction south (down).
		 */
		public static const SOUTH:int      = 5;
		/** 
		 * Compass-direction south-west (lower left).
		 */
		public static const SOUTH_WEST:int = 6;
		/** 
		 * Compass-direction west (left).
		 */
		public static const WEST:int       = 7;
		/** 
		 * Compass-direction north west (upper left).
		 */
		public static const NORTH_WEST:int = 8;
		
		
		///////////////////////////////////
		// horizontal or vertical
		///////////////////////////////////
		
		/** 
		 * Horizontal orientation. Used for scrollbars and sliders.
		 */
		public static const HORIZONTAL:int = 0;
		/** 
		 * Vertical orientation. Used for scrollbars and sliders.
		 */
		public static const VERTICAL:int   = 1;
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public static const ALIGN_TOP_LEFT:String = TOP+"_"+LEFT;
		public static const ALIGN_CENTER_LEFT:String = CENTER+"_"+LEFT;
		public static const ALIGN_BOTTOM_LEFT:String = BOTTOM+"_"+LEFT;
		
		public static const ALIGN_TOP_RIGHT:String = TOP+"_"+RIGHT;
		public static const ALIGN_CENTER_RIGHT:String = CENTER+"_"+RIGHT;
		public static const ALIGN_BOTTOM_RIGHT:String = BOTTOM+"_"+RIGHT;

		public static const ALIGN_TOP_CENTER:String = TOP+"_"+CENTER;
		public static const ALIGN_BOTTOM_CENTER:String = BOTTOM+"_"+CENTER;
		
		
		///////////////////////////////////
		// option pane
		///////////////////////////////////
		
		public static var OK_STR:String = "确 定";
		public static var CANCEL_STR:String = "取 消";
		public static var YES_STR:String = "是";
		public static var NO_STR:String = "否";
		public static var CLOSE_STR:String = "关 闭";
		
		public static const OK:int = 1; //00001
		public static const CANCEL:int = 2; //00010
		public static const YES:int = 4; //00100
		public static const NO:int = 8; //01000
		public static const CLOSE:int = 16; //10000
	}
}