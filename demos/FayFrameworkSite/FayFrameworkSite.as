package 
{
	import faysite.AppFaySiteFacade;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * Fay framework site.
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	[SWF(backgroundColor="0xFFFFFF", width="800", height="600", frameRate="30")]
	public class FayFrameworkSite extends MovieClip
	{
		public function FayFrameworkSite()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(event:Event=null):void
		{
			AppFaySiteFacade.getInstance().startup( this );
		}
	}
}
