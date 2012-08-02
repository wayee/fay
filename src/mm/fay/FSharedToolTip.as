package mm.fay
{
	import flash.display.InteractiveObject;
	import flash.utils.Dictionary;
	
	import mm.fay.basic.Component;

	/**
	 * A shared tooltip component.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FSharedToolTip extends FToolTip
	{
		private static var sharedInstance:FSharedToolTip;
		
		private var targetedComponent:InteractiveObject;
		private var textMap:Dictionary;
		
		public function FSharedToolTip()
		{
			super();
			textMap = new Dictionary(true);
		}
		
		public static function getSharedInstance():FSharedToolTip
		{
			if (sharedInstance == null) {
				sharedInstance = new FSharedToolTip();
			}
			return sharedInstance;
		}
		
		public static function setSharedInstance(ins:FSharedToolTip):void
		{
			if (sharedInstance) {
				throw new Error("sharedInstance is already set!");
			} else {
				sharedInstance = ins;
			}
		}
		
		/**
		 * Registers a component for shared tooltip. 
		 */
		public function registerComponent(c:InteractiveObject, tipText:String=null):void
		{
			listenOwner(c, true);
			textMap[c] = tipText;
			if (getTargetComponent() == c) {
				setTipText(getTargetToolTipText(c));
			}
		}
		
		/**
		 * Unregister a component for shared tooltip. 
		 */
		public function unregisterComponent(c:InteractiveObject):void
		{
			unlistenOwner(c);
			delete textMap[c];
			if (getTargetComponent() == c) {
				disposeToolTip();
				targetedComponent = null;
			}
		}
		
		/**
		 * Sets/gets the shared tooltip target component. 
		 */
		override public function setTargetComponent(c:InteractiveObject):void
		{
			registerComponent(c);
		}
		override public function getTargetComponent():InteractiveObject
		{
			return targetedComponent;
		}
		
		/**
		 * Gets the target component tooltip text content.
		 */
		protected function getTargetToolTipText(c:InteractiveObject):String
		{
			if (c is Component) {
				var co:Component = c as Component;
				return co.getToolTipText();
			} else {
				return textMap[c];
			}
		}
		
		
		///////////////////////////////////
		// Event handlers
		///////////////////////////////////
		
		override protected function _compRollOver(source:InteractiveObject):void
		{
			var tipText:String = getTargetToolTipText(source);
			if (tipText != null) {
				targetedComponent = source;
				setTipText(tipText);
				startWaitToPopup();
			}
		}
		
		override protected function _compRollOut(source:InteractiveObject):void
		{
			if (source == targetedComponent) {
				disposeToolTip();
				targetedComponent = null;
			}
		}
	}
}