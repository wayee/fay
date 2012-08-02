package mm.fay.util
{
	import flash.display.DisplayObject;

	/**
	 * A loader for loading images.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FLoader
	{
        public function FLoader()
		{
            throw new Error("FLoader is a static Class.");
        }
		
        public static function startLoad(url:String, width:int, height:int):DisplayObject
		{
            var loader:FLoaderContent = new FLoaderContent(width, height);
            loader.load(url);
            return loader;
        }
    }
}
import flash.display.Graphics;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import mm.fay.basic.Component;

class FLoaderContent extends Component
{
    private var loader:Loader;
    private var tf:TextField;
    private var _w:int;
    private var _h:int;
    private var count:int;
    private var _url:String;

    public function FLoaderContent(w:int, h:int)
	{
        super();
		
        this._w = w;
        this._h = h;
        var g:Graphics = graphics;
        with (g) {
            beginFill(0, 0.5);
            drawRect(0, 0, _w, _h);
            endFill();
        };
		
        this.tf = new TextField();
        addChild(this.tf);
		
        this.tf.text = "Loading...";
        this.tf.selectable = false;
        this.tf.autoSize = TextFieldAutoSize.CENTER;
        this.tf.background = true;
        this.tf.backgroundColor = 16777164;
        this.tf.textColor = 0;
        this.tf.x = (this._w - this.tf.width) / 2;
        this.tf.y = (this._h - this.tf.height) / 2;
		
        this.loader = new Loader();
        this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
        this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
        this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
        this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
    }
	
    private function onProgress(event:Event):void
	{
        var loaderInfo:LoaderInfo = (event.target as LoaderInfo);
        var progressText:int = ((loaderInfo.bytesLoaded / loaderInfo.bytesTotal) * 100);
        this.tf.text = (progressText.toString() + "%");
        this.tf.textColor = 0x9900;
    }
	
    private function onComplete(event:Event):void
	{
        var obj:* = null;
        obj = this.loader.content;
        obj.width = this._w;
        obj.height = this._h;
        addChild(obj);
        removeChild(this.tf);
        var g = graphics;
        with (g) {
            clear();
            beginFill(0, 0);
            drawRect(0, 0, _w, _h);
            endFill();
        };
        dispatchEvent(new Event(Event.COMPLETE));
    }
	
    private function onError(event:ErrorEvent):void
	{
        if (this.count < 3){
            this.load();
            trace(event.text);
        } else {
            trace(event.text);
            this.tf.text = "Failure";
            this.tf.textColor = 0x990000;
        }
    }
	
    public function load(url:String=""):void
	{
        var urlRequest:URLRequest;
        if (url != "") {
            this._url = url;
        }
        if (this._url) {
            urlRequest = new URLRequest(this._url);
            this.loader.load(urlRequest);
            this.count = (this.count + 1);
        }
    }
}