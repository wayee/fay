package mm.fay
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;
	
	import mm.fay.basic.UIComponent;
	
	/**
	 * FAttachPane, a container attach flash symbol in library to be its floor.
	 * 
	 * @example
	 * <listing version="3.0">
	 * var loadPane:FAttachPane = FAttachPane.create(stage)
	 * 									 	 .setSize(400, 300);
	 * loadPane.attach(className);
	 * </listing>
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FAttachPane extends UIComponent
	{
		private var _className:String;
		private var _applicationDomain:ApplicationDomain;
		private var _asset:DisplayObject;
		private var _width:int;
		private var _height:int;
		
		public function FAttachPane(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		/**
		 * create a instance.
		 */
		public static function create(parent:DisplayObjectContainer=null):FAttachPane
		{
			return new FAttachPane(parent);
		}

		private function _createAsset():DisplayObject
		{
			if (_className == null) return null;
			
			var classRef:Class;
			if (_applicationDomain == null) {
				classRef = getDefinitionByName(_className) as Class;
			} else {
				classRef = _applicationDomain.getDefinition(_className) as Class;
			}
			if (classRef == null) return null;
			
			var attachMc:DisplayObject = new classRef() as DisplayObject;
			
			return attachMc;
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public override function set width(w:Number):void
		{
			_width = w;
		}
		public override function get width():Number
		{
			return _width;
		}
		
		public override function set height(h:Number):void
		{
			_height = h;
		}
		public override function get height():Number
		{
			return _height;
		}
		
		public function attach(className:String, applicationDomain:ApplicationDomain=null):FAttachPane
		{
			_className = className;
			_applicationDomain == applicationDomain;
			setAsset(_createAsset());
			
			return this;
		}
		
		public function setAsset(asset:DisplayObject):void
		{
			if (_asset !== asset) {
				if (_asset && _asset.parent == this) {
					this.removeChild(_asset);
				}
				_asset = asset;
				if (asset) {
					this.addChild(_asset);
				}
			}
		}
		
		public function unloadAsset():void
		{
			setAsset(null);
		}
		
		public function getClassName():String
		{
			return _className;
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			unloadAsset();
			_className = '';
			_applicationDomain = null;
			
		}
	}
}