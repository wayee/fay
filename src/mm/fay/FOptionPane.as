package mm.fay
{
	import flash.events.MouseEvent;
	
	import mm.fay.basic.Container;
	import mm.fay.layout.HBoxUI;
	import mm.fay.layout.VBoxUI;
	import mm.fay.util.FConst;
	import mm.fay.util.FUtil;
	import mm.fay.vo.Insets;
	import mm.fay.vo.IntGap;
	import mm.fay.vo.IntPoint;
	
	/**
	 * Makes it easy to pop up a standard dialog box that prompts users
	 * for a value or informs them of somethings.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FOptionPane extends Container
	{
		private var _okButton:FButton;
		private var _cancelButton:FButton;
		private var _yesButton:FButton;
		private var _noButton:FButton;
		private var _closeButton:FButton;
		
		private var _buttonBox:HBoxUI;
		private var _vbox:VBoxUI;
		private var _frame:FFrame;
		private var _msgLabel:FLabel;
		private var _inputText:FTextField;
		
		public function FOptionPane(width:int = 320, height:int = 150)
		{
			super();
			
			_width = width;
			_height = height;
			
			_buttonBox = HBoxUI.create(null);
			_buttonBox.setSize(100, 30)
				.setAlign(HBoxUI.ALIGN_BOTTOM_LEFT)
				.setGap(new IntGap(10, 10))
				.setPadding(new Insets(0, 0, 0, 20))
			_msgLabel = new FLabel('温馨提示：叮叮咚咚大罗敲鼓拉动开发');
			_msgLabel.setSize(width - 40, 20);
			_inputText = new FTextField('');
			_inputText.setSize(width - 40, 20);
			
			_vbox = VBoxUI.create(this);
			_vbox.setSize(width, height-30)
				.setGap(new IntGap(5, 5))
				.setPadding(new Insets(5, 20, 0, 20))
				.setAlign(VBoxUI.ALIGN_TOP_LEFT);
//			_vbox.backgroundAlpha = .3;
			_vbox.addChild(_msgLabel);
			_vbox.addChild(_inputText);
			_vbox.addChild(_buttonBox);
		}
		
		
		///////////////////////////////////
		// buttons
		///////////////////////////////////
		
		public function setFrame(f:FFrame):void
		{
			_frame = f;
		}
		public function getFrame():FFrame
		{
			return _frame;
		}
		
		public function getOkButton():FButton
		{
			if (_okButton == null) {
				_okButton = new FButton(FConst.OK_STR);
				_okButton.setSize(60, 20);
			}
			return _okButton;
		}
		public function getCancelButton():FButton
		{
			if (_cancelButton == null) {
				_cancelButton = new FButton(FConst.CANCEL_STR);
				_cancelButton.setSize(60, 20);
			}
			return _cancelButton;
		}	
		public function getYesButton():FButton
		{
			if (_yesButton == null) {
				_yesButton = new FButton(FConst.YES_STR);
				_yesButton.setSize(60, 20);
			}
			return _yesButton;
		}
		public function getNoButton():FButton
		{
			if (_noButton == null) {
				_noButton = new FButton(FConst.NO_STR);
				_noButton.setSize(60, 20);
			}
			return _noButton;
		}
		public function getCloseButton():FButton
		{
			if (_closeButton == null) {
				_closeButton = new FButton(FConst.CLOSE_STR);
				_closeButton.setSize(60, 20);
			}
			return _closeButton;
		}	
		public function addButton(button:FButton):void
		{
			_buttonBox.addChild(button);
		}
		private function addCloseListener(button:FButton):void
		{
			var f:FFrame = getFrame();
			button.addEventListener(MouseEvent.CLICK, function():void{ f.dispose(); });
		}
		
		
		///////////////////////////////////
		// show dialog methods
		///////////////////////////////////
		
		/**
		 * Show a message box with yes and no buttons. 
		 */
		public static function showMessageDialog(title:String, msg:String, finishHandler:Function=null,
												modal:Boolean=true, buttons:int=FConst.OK):FOptionPane
		{
			var pane:FOptionPane = new FOptionPane;
			var handler:Function = finishHandler;
			var frame:FFrame = new FFrame(title, true);
			frame.setContentPane(pane);
			frame.setClosable(false);
			frame.setSize(pane.width, pane.height);
			
			pane.setFrame(frame);
			pane.setSize(pane.width, pane.height-30);
			
			if ((buttons & FConst.OK) == FConst.OK) {
				pane.addButton(pane.getOkButton());
				pane.addCloseListener(pane.getOkButton());
				pane.getOkButton().addEventListener(MouseEvent.CLICK, function():void {
					if (handler != null) handler(FConst.OK);
				});
			}
			if ((buttons & FConst.CANCEL) == FConst.CANCEL) {
				pane.addButton(pane.getCancelButton());
				pane.addCloseListener(pane.getCancelButton());
				pane.getCancelButton().addEventListener(MouseEvent.CLICK, function():void {
					if (handler != null) handler(FConst.CANCEL);
				});
			}
			if ((buttons & FConst.YES) == FConst.YES) {
				pane.addButton(pane.getYesButton());
				pane.addCloseListener(pane.getYesButton());
				pane.getYesButton().addEventListener(MouseEvent.CLICK, function():void {
					if (handler != null) handler(FConst.YES);
				});
			}
			if ((buttons & FConst.NO) == FConst.NO) {
				pane.addButton(pane.getNoButton());
				pane.addCloseListener(pane.getNoButton());
				pane.getNoButton().addEventListener(MouseEvent.CLICK, function():void {
					if (handler != null) handler(FConst.NO);
				});
			}
			if ((buttons & FConst.CLOSE) == FConst.CLOSE) {
				pane.addButton(pane.getCloseButton());
				pane.addCloseListener(pane.getCloseButton());
				pane.getCloseButton().addEventListener(MouseEvent.CLICK, function():void {
					if (handler != null) handler(FConst.CLOSE);
				});
			}
			
//			pane._buttonBox.x = pane.width/2 - pane._buttonBox.width/2;
//			pane._buttonBox.y = pane.height - pane._buttonBox.height - 5;
			pane._buttonBox.refresh();
			
			pane._vbox.refresh();
			
			var location:IntPoint = FUtil.getScreenCenterPosition();
			frame.setLocation(location.x-frame.width/2, location.y-frame.height/2);
			frame.show();
			
			return pane;
		}
		
		/**
		 * Show a message box with specified title, message, icon and a TextField to require user to input a string.
		 * @return 
		 * 
		 */
		public static function showInputDialog():FOptionPane
		{
			var pane:FOptionPane = new FOptionPane;
			
			return pane;
		}
	}
}