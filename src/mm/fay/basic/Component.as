package mm.fay.basic
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mm.fay.FSharedToolTip;
	import mm.fay.FayManager;
	import mm.fay.laf.IDecorator;
	import mm.fay.laf.UIDefaults;
	import mm.fay.laf.UIManager;
	import mm.fay.util.FUtil;
	import mm.fay.vo.FColor;
	import mm.fay.vo.FFont;
	import mm.fay.vo.IntPoint;
	import mm.fay.vo.IntRectangle;

	[Event(name="resize", type="flash.events.Event")]
	[Event(name="draw", type="flash.events.Event")]
	
	/**
	 * The super class of all components.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class Component extends FSprite
	{
		public static const DRAW:String = 'draw';

        protected var _pid:String;
        protected var _data:Object;
		protected var _enabled:Boolean;
		protected var _selected:Boolean;
		protected var _width:Number;
		protected var _height:Number;
		protected var _defaults:UIDefaults;
		protected var _font:FFont;
		protected var _background:FColor;
		protected var _foreground:FColor;
		protected var _icon:IDecorator;
		protected var _bgDecorator:IDecorator;
		protected var _draggable:Boolean;

		private var _toolTipText:String;
		
		/**
		 * Constructor
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param parent The parent DisplayObjectContainer on which to add this component.
		 */
        public function Component(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(true);
			
            _pid = FayManager.createId();
			
			_defaults = new UIDefaults;
			_enabled = true;
			_selected = false;
			_draggable = false;
			
			installUI();
			
			setLocation(xpos, ypos);
			if (parent != null) {
				parent.addChild(this);
			}
			
			FUtil.weakRegisterComponent(this); // for changing skin in runtime
        }

		/**
		 * Marks the component to be redrawn on the next frame. 
		 */
		protected function invalidate():void
		{
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}

		/**
		 * Called one frame after invalidate is called. 
		 */
		private function onInvalidate(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
		}
		
		/**
		 * Installs/uninstalls the component UI.
		 */
		protected function installUI():void
		{
			installDefaults();
			installComponents();
			installListeners();
		}
		protected function uninstallUI():void
		{
			uninstallDefaults();
			uninstallComponents();
			uninstallListeners();
		}
		
		/**
		 * Installs/uninstalls the laf properties of the component.
		 * 
		 */
		protected function installDefaults():void{ }
		protected function uninstallDefaults():void{ }
		
		/**
		 * Installs/uninstalls child display objects of the component.
		 */
		protected function installComponents():void{ }
		protected function uninstallComponents():void{ }
		
		/**
		 * Installs/uninstalls event listeners.
		 */
		protected function installListeners():void{ }
		protected function uninstallListeners():void{ }
		
		/**
		 * Installs the color and font. 
		 */
		protected function installColorAndFont():void
		{
			var pp:String = getPropertyPrefix();
			setForeground(getColor(pp + 'foreground'));
			setBackground(getColor(pp + 'background'));
			font = getFont(pp + 'font');
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Get the laf property prefix.
		 */
		public function getPropertyPrefix():String
		{
			return "Component.";
		}
		
		/**
		 * Abstract draw function.
		 */
		public function draw():void
		{
			setClipMaskRect(getDrawBounds());
			
			dispatchEvent(new Event(Component.DRAW));
		}
		
		/**
		 * Update the Look And Feel properties.
		 */
		public function updateLAF(uiDefaults:Array):void
		{
			_defaults.putDefaults(uiDefaults);
			
			installDefaults();
			
			invalidate();
		}
		
		public function drawBackground(color:uint=0x000000, alpha:Number=1, clear:Boolean=false):void
		{
			graphics.clear();
			if (clear) return;
			graphics.beginFill(color, alpha);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
		}
		
		public function drawBorder(color:uint=0x000000, lineStyle:int=1, clear:Boolean=false):void
		{
			graphics.clear();
			if (clear) return;
			graphics.lineStyle(lineStyle, color);
			graphics.beginFill(color, 0);
			graphics.drawRect(0, 0, _width-lineStyle, _height-lineStyle);
			graphics.endFill();
		}
		
		/**
		 * Dispose the component.
		 */
		public function dispose():void
		{
			setClipMasked(false);
			setBackgroundChild(null);
			setForegroundChild(null);
			uninstallUI();
		}
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets the background decorator to component. 
		 */
		public function setBgDecorator(bg:IDecorator):void
		{
			_bgDecorator = bg;
			setBackgroundChild(_bgDecorator ? _bgDecorator.getDisplay(this) : null);
		}
		
		/**
		 * Sets the icon decorator to component. 
		 */
		public function setIconDecorator(icon:IDecorator):void
		{
			_icon = icon;
			invalidate();
		}
		
		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		public function setSize(w:Number, h:Number):void
		{
			_width = w;
			_height = h;
			dispatchEvent(new Event(Event.RESIZE));
			invalidate();
		}
		
		/**
		 * Sets/gets the width of the component.
		 */
		override public function set width(w:Number):void
		{
			_width = w;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}
		override public function get width():Number
		{
			return _width;
		}
		
		/**
		 * Sets/gets the height of the component.
		 */
		override public function set height(h:Number):void
		{
			_height = h;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}
		override public function get height():Number
		{
			return _height;
		}
		
		/**
		 * Get the Mouse Position 
		 */
		public function getMousePosition():IntPoint
		{
			return new IntPoint(mouseX, mouseY);
		}
		
		/**
		 * Sets/gets whether this component is enabled or not.
		 */
		public function setEnabled(b:Boolean):void
		{
			if(isEnabled() == b) {
				return;
			}
			
			_enabled = b;
			mouseEnabled = mouseChildren = _enabled;
			tabEnabled = b;
		}
		public function isEnabled():Boolean
		{
			return _enabled;
		}
		
		/**
		 * Sets/gets whether this component is selected or not. 
		 */		
		public function setSelected(b:Boolean):void
		{
			if (isSelected() == b) {
				return;
			}
			
			_selected = b;
			invalidate();
		}
		public function isSelected():Boolean
		{
			return _selected;
		}
		
		/**
		 * Get the component bounds. 
		 */
		public function getDrawBounds():IntRectangle
		{
			return (new IntRectangle(0, 0, _width, _height));
		}
		
		/**
		 * Move the component to the specified position. 
		 * @param xpos the x position
		 * @param ypos the y position
		 */
		public function setLocation(xpos:Number, ypos:Number):void
		{
			this.x = Math.round(xpos);;
			this.y = Math.round(ypos);
		}
		
		/**
		 * Sets/gets the background color. 
		 */
		public function setBackground(color:FColor):void
		{
			_background = color;
		}
		public function getBackground():FColor
		{
			return _background;
		}
		
		/**
		 * Sets/gets the foreground color.
		 */
		public function setForeground(color:FColor):void
		{
			_foreground = color;
		}
		public function getForeground():FColor
		{
			return _foreground;
		}
		
		/**
		 * Sets/gets the font.
		 */
		public function set font(font:FFont):void
		{
			_font = font;
		}
		public function get font():FFont
		{
			return _font;
		}
		
		/**
		 * Get the unique id.
		 */
        public function get pid():String
		{
            return _pid;
        }
		
		/**
		 * Sets/gets whether or not the window will be draggable by the title bar. 
		 */
		public function setDraggable(b:Boolean):void
		{
			_draggable = b;
		}
		public function isDraggable():Boolean
		{
			return _draggable;
		}
        
		/**
		 * Sets/gets the extra data of the component. 
		 */
		public function set data(obj:Object):void
		{
            _data = obj;
        }
		public function get data():Object
		{
            return _data;
        }
		
		/**
		 * Sets/gets the tooltip text of the component. 
		 */
		public function setToolTipText(t:String):void
		{
			_toolTipText = t;
			if (t == null) {
				FSharedToolTip.getSharedInstance().unregisterComponent(this);
			}else{
				FSharedToolTip.getSharedInstance().registerComponent(this);
			}
		}
		public function getToolTipText():String
		{
			return _toolTipText;
		}
		
		/**
		 * Set a component to be hide or shown.
		 */
		public function setVisible(v:Boolean):void
		{
			visible = v;
		}
		public function isVisible():Boolean
		{
			return visible;
		}
		
		/**
		 * Determines whether or not this component is on stage(on the display list).
		 * @return turn of this component is on display list, false not.
		 */
		public function isOnStage():Boolean
		{
			return stage != null;
		}
		
		/**
		 * Determines whether this component is showing on screen. This means
		 * that the component must be visible, and it must be in a container
		 * that is visible and showing.
		 * @return <code>true</code> if the component is showing,
		 *          <code>false</code> otherwise
		 */    
		public function isShowing():Boolean
		{
			if (isOnStage() && isVisible()) {
				//here, parent is stage means this is the top component(ex root)
				if (parent == stage) {
					return true;
				} else {
					return FUtil.isDisplayObjectShowing(parent);
				}
			}
			return false;
		}
		
		
		///////////////////////////////////
		// Look and Feel methods
		///////////////////////////////////
		
		/**
		 * public methods to get the laf property. 
		 */		
		
		public function containsDefaultsKey(key:String):Boolean
		{
			return _defaults != null && _defaults.containsKey(key);
		}
		
		public function containsKey(key:String):Boolean
		{
			return containsDefaultsKey(key) || UIManager.containsKey(key);
		}
		
		public function getBoolean(key:String):Boolean
		{
			if (containsDefaultsKey(key)) {
				return _defaults.getBoolean(key);
			}
			return UIManager.getBoolean(key);
		}
		
		public function getNumber(key:String):Number
		{
			if (containsDefaultsKey(key)) {
				return _defaults.getNumber(key);
			}
			return UIManager.getNumber(key);
		}
		
		public function getInt(key:String):int
		{
			if (containsDefaultsKey(key)) {
				return _defaults.getInt(key);
			}
			return UIManager.getInt(key);
		}
		
		public function getUint(key:String):uint
		{
			if (containsDefaultsKey(key)) {
				return _defaults.getUint(key);
			}
			return UIManager.getUint(key);
		}
		
		public function getString(key:String):String
		{
			if (containsDefaultsKey(key)) {
				return _defaults.getString(key);
			}
			return UIManager.getString(key);
		}
		
		public function getColor(key:String):FColor
		{
			if (containsDefaultsKey(key)) {
				return _defaults.getColor(key);
			}
			return UIManager.getColor(key);
		}
		
		public function getFont(key:String):FFont
		{
			if (containsDefaultsKey(key)) {
				return _defaults.getFont(key);
			}
			return UIManager.getFont(key);
		}
		
		public function getDecorator(key:String):IDecorator
		{
			if (containsDefaultsKey(key)) {
				return _defaults.getDecorator(key);
			}
			return UIManager.getDecorator(key);
		}
		
		public function getInstance(key:String):*
		{
			if (containsDefaultsKey(key)) {
				return _defaults.getInstance(key);
			}
			return UIManager.getInstance(key);
		}
		
		public function getClass(key:String):Class
		{
			if (containsDefaultsKey(key)) {
				return _defaults.getConstructor(key);
			}
			return UIManager.getClass(key);
		}
		
		public function getInstanceWithArgs(key:String, arr:Array):*
		{
			var cls:Class = getClass(key);
			var instance:Object;
			if (cls == null) {
				return null;
			}
			var num:int = (arr) ? arr.length : 0;
			switch (num){
				case 0:
					instance = new (cls)();
					break;
				case 1:
					instance = new cls(arr[0]);
					break;
				case 2:
					instance = new cls(arr[0], arr[1]);
					break;
				case 3:
					instance = new cls(arr[0], arr[1], arr[2]);
					break;
				case 4:
					instance = new cls(arr[0], arr[1], arr[2], arr[3]);
					break;
				case 5:
					instance = new cls(arr[0], arr[1], arr[2], arr[3], arr[4]);
					break;
				case 6:
					instance = new cls(arr[0], arr[1], arr[2], arr[3], arr[4], arr[5]);
					break;
			}
			return instance;
		}
		
    }
}