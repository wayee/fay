package faysite.view.demos
{
	import flash.display.Sprite;
	
	import mm.fay.FCheckBox;

	/**
	 * FCheckBox Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FCheckBoxDemo extends Sprite
	{
        public function FCheckBoxDemo()
		{
            new FCheckBox("Item 1", this, 0, 10);
            new FCheckBox("Item 2", this, 0, 35);
            new FCheckBox("Item 3", this, 0, 60);
            new FCheckBox("Item 4", this, 0, 85);
        }
    }
} 
