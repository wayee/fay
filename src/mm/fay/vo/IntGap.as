package mm.fay.vo
{
	/**
	 * Contains the properties (horizontal and vertical) used to set a gap between
	 * the DisplayObject children of the Layout Class like FHBox, FVBox and FTile.
	 * 
	 * @example
	 * var tile:FTile = new FTile(stage, 400, 300);
	 * tile.childrenGap = new IntGap(10, 10);
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class IntGap
	{
		public var horizontal:int;
		public var vertical:int;
		
		public function IntGap(h:int=0, v:int=0)
		{
			horizontal = h;
			vertical = v;
		}
		
		public static function createIdentic(gap:int):IntGap
		{
			return new IntGap(gap, gap);
		}
		
		public function toString():String
		{
			return "Gap[" + "horizontal: " + horizontal + ", vertical: " + vertical + "]";
		}
	}
}