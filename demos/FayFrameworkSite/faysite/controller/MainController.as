package faysite.controller
{
	import faysite.AppFaySiteFacade;
	import faysite.view.MainPane;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mm.dida.Controller;
	import mm.dida.observer.Notification;
	import mm.fay.basic.AbstractButton;
	
	public class MainController extends Controller
	{
		public static const NAME:String = 'MainController';
		
		private var _mainPane:MainPane;
		
		public function MainController(viewComponent:Object=null)
		{
			super(viewComponent);
			
			_mainPane = MainPane(viewComponent);
		}
		
		override protected function onViewCreateComplete(e:Event):void
		{
		}
		
		override protected function onViewRemoveComplete(e:Event):void
		{
		}
		
		private function __onPaneClick(event:MouseEvent):void
		{
			var btn:AbstractButton = event.target as AbstractButton;
			
			if (btn) {
				_mainPane.sectionChosen(btn);
			}
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		override public function listNotificationInterests():Array 
		{
			return [
				AppFaySiteFacade.MAIN_PANE_ADD_TO_STAGE
			]; 
		}
		
		public function actionMainPaneAddToStage(note:Notification):void
		{
			_mainPane.initialize();
			_mainPane.menuVBox.addEventListener(MouseEvent.CLICK, __onPaneClick);
		}
		
	}
}