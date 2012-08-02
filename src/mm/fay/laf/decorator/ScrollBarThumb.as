package mm.fay.laf.decorator
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mm.fay.FJScrollBar;
	import mm.fay.basic.Component;
	import mm.fay.basic.FSprite;
	import mm.fay.event.ReleaseEvent;
	import mm.fay.laf.IDecorator;
	import mm.fay.util.FConst;
	import mm.fay.vo.IntDimension;
	import mm.fay.vo.IntRectangle;
	
	/**
	 * Scroll bar Thumb decorator.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class ScrollBarThumb implements IDecorator
	{
		protected var thumb:FSprite;
		protected var verticalContainer:ButtonStateObject;
		private var _comp:Component;
		
		protected var enabled:Boolean;
		protected var rollover:Boolean;
		protected var pressed:Boolean;
		
		protected var verticle:Boolean;
		protected var size:IntDimension;
		
		public function ScrollBarThumb()
		{
			thumb = new FSprite;
			thumb.tabEnabled = false;
			
			rollover = false;
			pressed = false;
			enabled = true;
			verticle = false;
			initSelfHandlers();
		}
		
		private function checkReloadAssets(c:Component):void
		{
			if (verticalContainer) {
				return;
			}
			
			var pp:String = c.getPropertyPrefix();
			verticalContainer = new ButtonStateObject();
			verticalContainer.setDefaultImage(c.getInstance(pp + "thumbVerticalDefaultImage"));
			verticalContainer.setPressedImage(c.getInstance(pp + "thumbVerticalPressedImage"));
			verticalContainer.setDisabledImage(c.getInstance(pp + "thumbVerticalDisabledImage"));
			verticalContainer.setRolloverImage(c.getInstance(pp + "thumbVerticalRolloverImage"));
			
			thumb.mouseEnabled = c.isEnabled();
		}
		
		public function updateDecorator(c:Component, r:IntRectangle=null):void
		{
			checkReloadAssets(c);
			
			thumb.x = r.x;
			thumb.y = r.y;
			size = r.getSize();
			enabled = c.isEnabled();
			verticle = FJScrollBar(c).getOrientation() == FConst.VERTICAL;
			paint();
			
		}
		
		public function getDisplay(c:Component=null):InteractiveObject
		{
			checkReloadAssets(c);
			return thumb;
		}
		
		protected function paint():void
		{
			if (verticle) {
				if (!thumb.contains(verticalContainer.getDisplay())) {
					thumb.addChild(verticalContainer.getDisplay());
				}
				// TODO
				verticalContainer.setEnabled(enabled);
				verticalContainer.setPressed(pressed);
				verticalContainer.setRollovered(rollover);
				verticalContainer.updateDecorator(null);
			}
			thumb.mouseEnabled = enabled;
		}
		
		private function initSelfHandlers():void
		{
			thumb.addEventListener(MouseEvent.ROLL_OUT, __onRollOut);
			thumb.addEventListener(MouseEvent.ROLL_OVER, __onRollOver);
			thumb.addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
			thumb.addEventListener(ReleaseEvent.RELEASE, __onMouseUp);
		}
		
		private function __onRollOver(event:Event):void
		{
			rollover = true;
			paint();
		}
		
		private function __onRollOut(event:Event):void
		{
			rollover = false;
			if (!pressed) {
				paint();
			}
		}
		
		private function __onMouseDown(event:Event):void
		{
			pressed = true;
			paint();
		}
		
		private function __onMouseUp(event:Event):void
		{
			if (pressed) {
				pressed = false;
				paint();
			}
		}
	}
}