package faysite.view.demos
{
	import flash.display.Sprite;
	
	import mm.fay.FButton;
	import mm.fay.FToggleButton;

	/**
	 * FButton Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FButtonDemo extends Sprite
	{
        public function FButtonDemo()
		{
            new FButton("Regular Button", this, 0, 0);
            new FToggleButton("Toggle Button", this, 0, 25);
        }
    }
}