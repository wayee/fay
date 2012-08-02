package faysite
{
	import faysite.controller.MainController;
	import faysite.view.MainPane;
	
	import flash.display.DisplayObjectContainer;
	
	import mm.dida.Facade;
	import mm.fay.FayManager;
	
	/**
	 * Application Facade of Fay site.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class AppFaySiteFacade extends Facade
	{
		///////////////////////////////////
		// Notification
		///////////////////////////////////
		public static const MAIN_PANE_ADD_TO_STAGE:String = 'MainPaneAddToStage';
		
		public static function getInstance():AppFaySiteFacade
		{
			if (instance == null) instance = new AppFaySiteFacade;
			return instance as AppFaySiteFacade;
		}
		
		override protected function initializeFacade():void
		{
			super.initializeFacade();
		}
		
		public function startup(root:DisplayObjectContainer):void
		{
			FayManager.initFay(root);
			
			var mainPane:MainPane = new MainPane;
			registerController( new MainController(mainPane) );
			
			root.addChild(mainPane);
			sendNotification( MAIN_PANE_ADD_TO_STAGE );
		}
	}
}