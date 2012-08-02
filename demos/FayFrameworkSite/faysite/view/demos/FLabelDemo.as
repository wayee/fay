package faysite.view.demos
{
	import flash.display.Sprite;
	import mm.fay.FLabel;
	
	/**
	 * FLabel Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FLabelDemo extends Sprite
	{
        public function FLabelDemo()
		{
            new FLabel("Simple Label", this, 0, 0).setSize(200, 20);
        }
    }
}