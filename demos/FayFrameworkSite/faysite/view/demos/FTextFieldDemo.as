package faysite.view.demos
{
	import flash.display.Sprite;
	import mm.fay.FTextField;

	/**
	 * FTextField Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FTextFieldDemo extends Sprite
	{
        public function FTextFieldDemo()
		{
            var _tf:FTextField = new FTextField('This is a single line input text.', this);
			_tf.setSize(200, 20);
        }
    }
}