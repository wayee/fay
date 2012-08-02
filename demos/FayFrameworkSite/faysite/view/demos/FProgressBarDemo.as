package faysite.view.demos
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mm.fay.FButton;
	import mm.fay.FProgressBar;

	/**
	 * FProgressBar Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FProgressBarDemo extends Sprite
	{
        private var pb:FProgressBar;
        private var progress:Number = 0;
        private var timer:Timer;

        public function FProgressBarDemo()
		{
            this.pb = new FProgressBar(this, 0, 0);
            this.timer = new Timer(100, 100);
            this.timer.addEventListener(TimerEvent.TIMER, __onTimer);
            this.timer.start();
            var btnReset:FButton = new FButton("Reset", this, 0, 20);
			btnReset.addEventListener(MouseEvent.CLICK, __onReset);
        }
		
        private function __onTimer(event:TimerEvent):void
		{
            this.progress = (this.progress + 0.01);
            this.pb.value = this.progress;
			trace(this.pb.value);
        }
		
        private function __onReset(event:MouseEvent):void
		{
            this.progress = 0;
            this.timer.reset();
            this.timer.start();
        }

    }
}