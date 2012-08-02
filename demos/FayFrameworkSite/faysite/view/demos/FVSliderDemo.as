package faysite.view.demos
{
	import flash.display.Sprite;
	import mm.fay.FVSlider;
	
	/**
	 * FVSlider Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FVSliderDemo extends Sprite
	{
        public function FVSliderDemo()
		{
            var _vsd:FVSlider = new FVSlider(null, this);
			_vsd.maximum = 100;
			_vsd.value = 50;
        }
    }
}