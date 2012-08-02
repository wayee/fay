package faysite.view.demos
{
	import flash.display.Sprite;
	import mm.fay.FHSlider;
	
	/**
	 * FHSlider Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FHSliderDemo extends Sprite
	{
        public function FHSliderDemo()
		{
            var _hsd:FHSlider = new FHSlider(null, this);
			_hsd.maximum = 100;
			_hsd.value = 50;
        }
    }
}