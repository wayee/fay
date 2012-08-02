package mm.fay.laf
{
	import mm.fay.laf.decorator.EmptyDecorator;
	import mm.fay.vo.FColor;
	import mm.fay.vo.FFont;
	import mm.fay.vo.HashMap;
	
	/**
	 * A table of defaults for Fay components.  Applications can set/get
 	 * default values via the <code>UIManager</code>.
	 * 
	 * @see UIManager
	 * @author Andy Cai (huayicai@gmail.com)
	 */
	public class UIDefaults extends HashMap
	{
		public function UIDefaults()
		{
			super();
		}
		
		/**
		 * Sets the value of <code>key</code> to <code>value</code>.
		 * If value is <code>null</code>, the key is removed from the table.
		 */	
		override public function put(key:*, value:*):*
		{
			var oldValue:* = (value == null) ? super.remove(key) : super.put(key, value);
			return oldValue;
		}
		
		public function putDefaults(keyValueList:Array):void
		{
			for(var i:Number = 0; i < keyValueList.length; i += 2) {
				var value:* = keyValueList[i + 1];
				if (value == null) {
					super.remove(keyValueList[i]);
				}else {
					super.put(keyValueList[i], value);
				}
			}
		}
		
		public function getBoolean(key:String):Boolean
		{
			return (this.get(key) == true);
		}
		
		public function getNumber(key:String):Number
		{
			return this.get(key) as Number;
		}
		
		public function getInt(key:String):int
		{
			return this.get(key) as int;
		}
		
		public function getUint(key:String):uint
		{
			return this.get(key) as uint;
		}
		
		public function getString(key:String):String
		{
			return this.get(key) as String;
		}
		
		public function getColor(key:String):FColor
		{
			var color:FColor = getInstance(key) as FColor;
			if (color == null) {
				color = new FColor;
			}
			return color;
		}
		
		public function getFont(key:String):FFont
		{
			var font:FFont = getInstance(key) as FFont;
			if (font == null) {
				font = new FFont;
			}
			return font;
		}
		
		public function getDecorator(key:String):IDecorator
		{
			var dec:IDecorator = getInstance(key) as IDecorator;
			if (dec == null) {
				dec = EmptyDecorator.INSTANCE;
			}
			return dec;
		}
		
		
		///////////////////////////////////
		// Gets the instance or class.
		///////////////////////////////////
		
		public function getConstructor(key:String):Class
		{
			return this.get(key) as Class;
		}
		
		public function getInstance(key:String):*
		{
			var value:* = this.get(key);
			if (value is Class) {
				return getCreateInstance(value as Class);
			} else {
				return value;
			}
		}
		
		private function getCreateInstance(constructor:Class):Object
		{
			return new constructor();
		}
	}
	
}