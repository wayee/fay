package faysite.view.demos
{
	import flash.display.Sprite;
	import mm.fay.FTextArea;
	
	/**
	 * FTextArea Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FTextAreaDemo extends Sprite
	{
        public function FTextAreaDemo()
		{
            var _tf:FTextArea = new FTextArea('This is a mutiple line input text.', this);
			_tf.setSize(100, 100);
			_tf.autoHideScrollBar = true;
			_tf.setWordWrap(true);
        }
    }
}