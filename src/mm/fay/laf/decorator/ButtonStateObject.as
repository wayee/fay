package mm.fay.laf.decorator
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	
	import mm.fay.basic.Component;
	import mm.fay.laf.IDecorator;
	import mm.fay.vo.IntRectangle;
	
	/**
	 * Button state object decorator.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class ButtonStateObject implements IDecorator
	{
		protected var _defaultImage:DisplayObject;
		protected var _pressedImage:DisplayObject;
		protected var _pressedSelectedImage:DisplayObject;
		protected var _disabledImage:DisplayObject;
		protected var _selectedImage:DisplayObject;
		protected var _disabledSelectedImage:DisplayObject;
		protected var _rolloverImage:DisplayObject;
		protected var _rolloverSelectedImage:DisplayObject;
		protected var _defaultButtonImage:DisplayObject;
		protected var _fixedPrefix:String;
		
		protected var _enabled:Boolean = true;
		protected var _pressed:Boolean = false;
		protected var _selected:Boolean = false;
		protected var _rollovered:Boolean = false;
		
		protected var lastViewedImage:DisplayObject;
		
		private var _disp:Sprite;
		
		public function ButtonStateObject(fixedPrefix:String=null)
		{
			_fixedPrefix = fixedPrefix;
			
			_disp = new Sprite;
			_disp.name = "ButtonStateObject";
			_disp.mouseEnabled = false;
			_disp.tabEnabled = false;
		}
		
		protected function getPropertyPrefix():String
		{
			if (_fixedPrefix != null) {
				return _fixedPrefix;
			}
			return "Component.";
		}
		
		private function checkReloadAssets(c:Component):void
		{
			if (_defaultImage) {
				return;
			}
			var pp:String = getPropertyPrefix();
			setDefaultImage(c.getInstance(pp + 'defaultImage'));
			setRolloverImage(c.getInstance(pp + 'rolloverImage'));
			setPressedImage(c.getInstance(pp + 'pressedImage'));
			setDisabledImage(c.getInstance(pp + 'disabledImage'));
			
			setSelectedImage(c.getInstance(pp + 'selectedImage'));
			setRolloverSelectedImage(c.getInstance(pp + 'rolloverSelectedImage'));
			setPressedSelectedImage(c.getInstance(pp + 'pressedSelectedImage'));
			setDisabledSelectedImage(c.getInstance(pp + 'disabledSelectedImage'));
		}
		
		protected function checkAsset(image:DisplayObject):void
		{
			if (image != null && _disp.contains(image)) {
				throw new Error("You are set a already exists asset!");
			}
		}
		
		private function addChild(child:DisplayObject):DisplayObject
		{
			if (child != null) {
				child.visible = false;
				return _disp.addChild(child);
			}
			return null;
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public function updateDecorator(c:Component, r:IntRectangle=null):void
		{
			checkReloadAssets(c);
			
			var image:DisplayObject = _defaultImage;
			var tmpImage:DisplayObject;
			if (!_enabled) {
				if (_selected && _disabledSelectedImage) {
					tmpImage = _disabledSelectedImage;
				} else {
					tmpImage = _disabledImage;
				}
			} else if (_pressed) {
				if (_selected && _pressedSelectedImage) {
					tmpImage = _pressedSelectedImage;
				} else {
					tmpImage = _pressedImage;
				}
			} else if (_rollovered) {
				if (_selected && _rolloverSelectedImage) {
					tmpImage = _rolloverSelectedImage;
				} else {
					tmpImage = _rolloverImage;
				}
			} else if (_selected) {
				tmpImage = _selectedImage;
			}
			if (tmpImage != null) {
				image = tmpImage;
			}
			if (image != lastViewedImage) {
				if (lastViewedImage) lastViewedImage.visible = false;
				if (image) image.visible = true;
				lastViewedImage = image;
			}
			if (r != null) {
				if (image) {
					image.width = r.width;
					image.height = r.height;
				}
				_disp.x = r.x;
				_disp.y = r.y;
			}
		}
		
		public function getDisplay(c:Component=null):InteractiveObject
		{
			return _disp;
		}
		
		public function setEnabled(b:Boolean):void
		{
			this._enabled = b;
		}
		
		public function setPressed(b:Boolean):void
		{
			this._pressed = b;
		}
		
		public function setSelected(b:Boolean):void
		{
			this._selected = b;
		}
		
		public function setRollovered(b:Boolean):void
		{
			this._rollovered = b;
		}
		
		public function setDefaultImage(image:DisplayObject):void
		{
			checkAsset(_defaultImage);
			_defaultImage = image;
			addChild(image);
		}
		
		public function setPressedImage(image:DisplayObject):void
		{
			checkAsset(_pressedImage);
			_pressedImage = image;
			addChild(image);
		}
		
		public function setPressedSelectedImage(image:DisplayObject):void
		{
			checkAsset(_pressedSelectedImage);
			_pressedSelectedImage = image;
			addChild(image);
		}
		
		public function setDisabledImage(image:DisplayObject):void
		{
			checkAsset(_disabledImage);
			_disabledImage = image;
			addChild(image);
		}
		
		public function setSelectedImage(image:DisplayObject):void
		{
			checkAsset(_selectedImage);
			_selectedImage = image;
			addChild(image);
		}
		
		public function setDisabledSelectedImage(image:DisplayObject):void
		{
			checkAsset(_disabledSelectedImage);
			_disabledSelectedImage = image;
			addChild(image);
		}
		
		public function setRolloverImage(image:DisplayObject):void
		{
			checkAsset(_rolloverImage);
			_rolloverImage = image;
			addChild(image);
		}
		
		public function setRolloverSelectedImage(image:DisplayObject):void
		{
			checkAsset(_rolloverSelectedImage);
			_rolloverSelectedImage = image;
			addChild(image);
		}
	}
}