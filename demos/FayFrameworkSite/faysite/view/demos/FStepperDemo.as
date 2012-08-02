package faysite.view.demos
{
	import flash.display.Sprite;
	
	import mm.fay.FStepper;

	/**
	 * FStepper Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FStepperDemo extends Sprite
	{
        public function FStepperDemo()
		{
            new FStepper(null, this, 0, 0);
        }
    }
}