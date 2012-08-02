package mm.fay
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	import mm.fay.FLabel;
	import mm.fay.basic.Component;
	import mm.fay.util.FUtil;
	
	/**
	 * The title bar of Frame.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FrameTitleBar extends Component
	{
		protected var _textFilters:Array;
		
		private var _titleLabel:TextField;
		private var _text:String;
		private var _barHeight:int;
		
		public function FrameTitleBar(text:String="", parent:DisplayObjectContainer = null)
		{
			super(parent);
			
			_text = text;
		}
		
		override protected function installDefaults():void
		{
			installColorAndFont();
			
			var pp:String = getPropertyPrefix();
			setTextFilters(getInstance(pp + "textFilters"));
			
			_barHeight = getInt("FrameTitleBar.titleBarHeight");
			
			buttonMode = true;
			mouseChildren = false;
		}
		
		override protected function installComponents():void
		{
			_titleLabel = new TextField;
			addChild(_titleLabel);
		}
		override protected function uninstallComponents():void
		{
			removeChild(_titleLabel);
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		override public function getPropertyPrefix():String
		{
			return 'FrameTitleBar.';
		}
		
		override public function draw():void
		{
			super.draw();
			
			if (_text != null && _text != "") {
				_titleLabel.visible = true;
				bringToTop(_titleLabel);
				
				if (_titleLabel.text != _text) {
					_titleLabel.text = _text;
				}
				FUtil.applyTextFont(_titleLabel, font);
				FUtil.applyTextColor(_titleLabel, getForeground());
				_titleLabel.filters = getTextFilters();
				
				_titleLabel.width = this.width;
				_titleLabel.height = this.height < _barHeight ? _barHeight : this.height;
				
			} else {
				_titleLabel.text = "";
				_titleLabel.visible = false;
			}
		}
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function getText():String
		{
			return _text;
		}
		public function setText(value:String):void
		{
			_text = value;
			invalidate();
		}
		
		/**
		 * Sets/gets the text filters.
		 */
		public function setTextFilters(fs:Array):void
		{
			_textFilters = fs;
			invalidate();
		}
		public function getTextFilters():Array
		{
			return _textFilters;
		}
		
		public function getTitleBarHeight():int
		{
			return _titleLabel.height;
		}
	}
}