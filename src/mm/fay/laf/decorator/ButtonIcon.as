package mm.fay.laf.decorator
{
	import mm.fay.basic.Component;
	import mm.fay.laf.IDecorator;

	/**
	 * Button Icon decorator.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class ButtonIcon extends ButtonStateObject implements IDecorator
	{
		protected var _iconWidth:int = 14;
		protected var _iconHeight:int = 14;
		
		public function ButtonIcon(fixedPrefix:String=null)
		{
			super(fixedPrefix);
			
			getDisplay(null).name = "ButtonIcon";
		}
		
		public function getIconWidth(c:Component):int
		{
			return _iconWidth;
		}
		
		public function getIconHeight(c:Component):int
		{
			return _iconHeight;
		}
	}
}