package mm.fay.laf.decorator
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	
	import mm.fay.basic.Component;
	import mm.fay.basic.TextComponent;
	import mm.fay.laf.IDecorator;
	import mm.fay.vo.IntRectangle;
	
	/**
	 * Text component background decorator.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class TextComponentBackground implements IDecorator
	{
		private var defaultImage:DisplayObject;
		private var uneditableImage:DisplayObject;
		private var disabledImage:DisplayObject;
		private var lastViewedImage:DisplayObject;
		
		private var _bg:Sprite;
		
		public function TextComponentBackground()
		{
			_bg = new Sprite;
			_bg.name = "TextFieldBackground";
			_bg.mouseEnabled = false;
			_bg.tabEnabled = false;
		}
		
		protected function checkAsset(image:DisplayObject):void
		{
			if (image != null && _bg.contains(image)) {
				throw new Error("You are set a already exists asset!");
			}
		}
		
		private function checkReloadAssets(c:Component):void
		{
			if (lastViewedImage) {
				return;
			}
			var pp:String = c.getPropertyPrefix();
			setDefaultImage(c.getInstance(pp + 'defaultImage'));
			setUneditableImage(c.getInstance(pp + 'uneditableImage'));
			setDisabledImage(c.getInstance(pp + 'disabledImage'));
		}
		
		private function addChild(child:DisplayObject):DisplayObject
		{
			if (child != null) {
				child.visible = false;
				return _bg.addChild(child);
			}
			return null;
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public function setDefaultImage(image:DisplayObject):void
		{
			checkAsset(defaultImage);
			defaultImage = image;
			addChild(image);
		}
		
		public function setUneditableImage(image:DisplayObject):void
		{
			checkAsset(uneditableImage);
			uneditableImage = image;
			addChild(image);
		}
		
		public function setDisabledImage(image:DisplayObject):void
		{
			checkAsset(disabledImage);
			disabledImage = image;
			addChild(image);
		}
		
		public function updateDecorator(c:Component, r:IntRectangle=null):void
		{
			checkReloadAssets(c);
			
			var tf:TextComponent = TextComponent(c);
			var tmpImage:DisplayObject = defaultImage;
			if (lastViewedImage) lastViewedImage.visible = false;
			if (tf.isEnabled()) {
				if (tf.isEditable()) {
					tmpImage = uneditableImage;
				}
			} else {
				tmpImage = disabledImage;
			}
			if (tmpImage) tmpImage.visible = true;
			lastViewedImage = tmpImage;
			
			if (r != null) {
				if (tmpImage) {
					tmpImage.width = r.width;
					tmpImage.height = r.height;
				}
				_bg.x = r.x;
				_bg.y = r.y;
			}
		}
		
		public function getDisplay(c:Component=null):InteractiveObject
		{
			return _bg;
		}
	}
}