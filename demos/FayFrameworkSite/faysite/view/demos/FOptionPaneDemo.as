package faysite.view.demos
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import mm.fay.FButton;
	import mm.fay.FOptionPane;
	import mm.fay.util.FConst;
	
	/**
	 * FOptionPane Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FOptionPaneDemo extends Sprite
	{
        public function FOptionPaneDemo()
		{
           new FButton("Open option pane", this, 0, 0).addEventListener(MouseEvent.CLICK, __onClick);
        }
		
		private function __onClick(e:MouseEvent):void 
		{
			FOptionPane.showMessageDialog('Title', 'Message...', null, true, FConst.OK|FConst.CANCEL);
		}
    }
}