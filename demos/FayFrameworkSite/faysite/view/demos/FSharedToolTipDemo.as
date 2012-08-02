package faysite.view.demos
{
	import flash.display.Sprite;
	
	import mm.fay.FButton;

	/**
	 * FSharedToolTip Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FSharedToolTipDemo extends Sprite
	{
        public function FSharedToolTipDemo()
		{
            new FButton("Tooltip Button", this, 0, 0).setToolTipText('Fay component tooltip using setToolTipText method. <br>And the InteractiveObject can share the tooltip too <br>using FSharedToolTip.registerComponent method.');
        }
    }
}