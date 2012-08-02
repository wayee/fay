package mm.fay
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	
	import mm.fay.basic.UIComponent;
	
	[Event(name="complete", type="flash.events.Event")]
	/**
	 * FLoadPane, a container load a external image/animation to be its asset.
	 * 
	 * @example
	 * <listing version="3.0">
	 * var loadPane:FLoadPane = FLoadPane.create(stage)
	 * 									 .setSize(400, 300);
	 * loadPane.load(url);
	 * </listing>
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FLoadPane extends UIComponent
	{
		private var _loader:Loader;
		private var _count:int;
		private var _url:String;
		private var _asset:DisplayObject;
		private var _width:int;
		private var _height:int;
		
		public function FLoadPane(parent:DisplayObjectContainer=null)
		{
			super(parent);
			
			_width = 0;
			_height = 0;
			_count = 0;
			
			_loader = new Loader;
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __onComplete);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, __onProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __onError);
			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, __onError);
		}
		
		/**
		 * create a instance.
		 */
		public static function create(parent:DisplayObjectContainer=null):FLoadPane
		{
			return new FLoadPane(parent);
		}
		
		private function _tryLoad():void
		{
			load(_url);
		}

		private function __onError(event:IOErrorEvent):void
		{
			if (_count < 3) {
				_tryLoad();
			} else {
				trace('Loading failed. URL: ', _url);
			}
		}

		private function __onProgress(event:ProgressEvent):void
		{
			//
		}

		private function __onComplete(event:Event):void
		{
			var disp:DisplayObject = _loader.content;
			setAsset(disp);
			if (_width==0) _width = disp.width;
			if (_height==0) _height = disp.height;
			dispatchEvent(new Event(Event.COMPLETE));
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
		
		public function load(url:String):FLoadPane
		{
			if (url != '') {
				_url = url;
				_loader.load(new URLRequest(url));
				_count = _count + 1;
			}
			
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
		
		override public function dispose():void
		{
			super.dispose();
			
			unloadAsset();
			_count = 0;
			_url = '';
			
		}
	}
}