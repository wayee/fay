package faysite.view.demos
{
	import flash.display.Sprite;
	import mm.fay.FPanel;
	
	/**
	 * FPanel Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FPanelDemo extends Sprite
	{
        public function FPanelDemo()
		{
            new FPanel(this, 0, 0).setSize(200, 200);
        }
    }
}