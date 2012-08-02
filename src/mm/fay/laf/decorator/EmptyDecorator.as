package mm.fay.laf.decorator
{
	import flash.display.InteractiveObject;
	
	import mm.fay.basic.Component;
	import mm.fay.laf.IDecorator;
	import mm.fay.vo.FColor;
	import mm.fay.vo.FFont;
	import mm.fay.vo.IntRectangle;
	
	/**
	 * A empty decorator.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class EmptyDecorator implements IDecorator
	{
		public static const INSTANCE:EmptyDecorator = new EmptyDecorator();
		
		public static const DEFAULT_BACKGROUND_COLOR:FColor = new FColor(0x000000);
		public static const DEFAULT_FOREGROUND_COLOR:FColor = new FColor(0xFFFFFF);
		public static const DEFAULT_FONT:FFont = new FFont();
		
		public function EmptyDecorator()
		{
		}
		
		public function updateDecorator(c:Component, r:IntRectangle=null):void
		{
		}
		
		public function getDisplay(c:Component=null):InteractiveObject
		{
			return null;
		}
	}
}