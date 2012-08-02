package mm.fay.laf
{
	import flash.display.InteractiveObject;
	
	import mm.fay.basic.Component;
	import mm.fay.vo.IntRectangle;

	/**
	 * The decorator interface.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public interface IDecorator
	{
		function updateDecorator(c:Component, r:IntRectangle=null):void;
		function getDisplay(c:Component=null):InteractiveObject;
	}
}