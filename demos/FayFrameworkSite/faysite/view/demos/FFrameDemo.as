package faysite.view.demos
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import mm.fay.FFrame;
	
	import mm.fay.FButton;

	/**
	 * FFrameDemo Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FFrameDemo extends Sprite
	{
		private var frame:FFrame;
		
        public function FFrameDemo()
		{
            new FButton("Open Frame", this, 0, 0).addEventListener(MouseEvent.CLICK, __onClick);
        }
		
		private function __onClick(e:MouseEvent):void 
		{
			if (frame == null) frame = new FFrame('This is a frame', true);
			frame.setSize(300, 300);
			frame.show();
		}
    }
}