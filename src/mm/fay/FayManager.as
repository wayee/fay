package mm.fay
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import mm.fay.vo.IntDimension;
	
	/**
	 * The main manager for Fay framework.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FayManager
	{
		/**
		 * Component instance index
		 */
		private static var INSTANCE_INDEX:int = 2147483647;
		
		private static var _stage:Stage = null;
		private static var _root:DisplayObjectContainer = null;
		private static var INITIAL_STAGE_WIDTH:int;
		private static var INITIAL_STAGE_HEIGHT:int;
		
		/**
		 * Initializes Fay as a standard setting.
		 * @param root default root
		 * 
		 */		
		public static function initFay(root:DisplayObjectContainer):void
		{
			setRoot(root);
			if (_stage) {
				_stage.align = StageAlign.TOP_LEFT;
				_stage.scaleMode = StageScaleMode.NO_SCALE;
				_stage.stageFocusRect = false;
			}
		}
		
		public static function setRoot(root:DisplayObjectContainer):void
		{
			_root = root;
			if (root != null && _stage == null && root.stage != null) {
				initStage(root.stage);
			}
		}
		public static function getRoot():DisplayObjectContainer
		{
			return _root;
		}	

		private static function initStage(stage:Stage):void
		{
			if (_stage == null) {
				_stage = stage;
				INITIAL_STAGE_WIDTH = stage.stageWidth;
				INITIAL_STAGE_HEIGHT = stage.stageHeight;
			}
		}
		public static function isStageInited():Boolean
		{
			return _stage != null;
		}
		public static function getStage():Stage
		{
			return _stage;
		}
		
		public static function setInitialStageSize(width:int, height:int):void
		{
			INITIAL_STAGE_WIDTH = width;
			INITIAL_STAGE_HEIGHT = height;
		}
		public static function getInitialStageSize():IntDimension
		{
			if(_root == null){
				throw new Error('need initialize the Fay framework.');
			}
			return new IntDimension(INITIAL_STAGE_WIDTH, INITIAL_STAGE_HEIGHT);
		}
		
		public static function createId():String
		{
			if (INSTANCE_INDEX <= 0) {
				INSTANCE_INDEX = int.MAX_VALUE;
			}
			INSTANCE_INDEX--;
			return "@FAY-UI-" + INSTANCE_INDEX;
		}
	}
}