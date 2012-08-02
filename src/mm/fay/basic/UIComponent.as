package mm.fay.basic
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	/**
	 * The super class of all components. It's a light-weight FComponent.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class UIComponent extends Sprite
	{
		private var _data:Object;
		
		public function UIComponent(parent:DisplayObjectContainer=null)
		{
			if (parent != null) {
				parent.addChild(this);
			}
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public function setSize(w:int, h:int):UIComponent
		{
			this.width = w;
			this.height = h;
			
			return this;
		}
		
		public function setLocation(xpos:Number, ypos:Number):UIComponent
		{
			this.x = Math.round(xpos);
			this.y = Math.round(ypos);
			
			return this;
		}
		
		override public function toString():String
		{
			var p:DisplayObject = this;
			var str:String = p.name;
			while (p.parent != null) {
				var name:String = (p.parent == p.stage ? 'Stage' : p.parent.name);
				p = p.parent;
				str = name + '.' + str;
			}
			return str;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}
		
		public function dispose():void
		{
			_data = null
		}

	}
}