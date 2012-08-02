package mm.fay.laf
{
	import flash.utils.getDefinitionByName;
	
	import mm.fay.vo.FColor;
	import mm.fay.vo.FFont;

	/**
	 * This class keeps track of the current look and feel and its defaults.
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 */	
	public class UIManager
	{
		private static var lookAndFeelDefaults:UIDefaults;
		private static var lookAndFeel:LookAndFeel;
		
		public static function setLaf(xml:XML):void
		{
			var comp:XML;
			var symbol:XML;
			var key:String;
			for(var i:int = 0; i < xml.children().length(); i++) {
				comp = xml.children()[i];
				for (var j:int = 0; j< comp.children().length(); j++) {
					symbol = comp.children()[j];
					key = comp.name() + '.' + symbol.name();
					getDefaults().put(key, getDefinitionByName(symbol.@name) as Class);
				}
			}
		}
		
		/**
		 * @see org.aswing.ASWingUtils#updateAllComponentUI()
		 */
		public static function setLookAndFeel(laf:LookAndFeel):void
		{
			lookAndFeel = laf;
			setLookAndFeelDefaults(laf.getDefaults());
		}
		
		public static function getLookAndFeel():LookAndFeel
		{
			checkLookAndFeel();
			return lookAndFeel;
		}
		
		public static function getDefaults():UIDefaults
		{
			return getLookAndFeelDefaults();
		}
		
		public static function getLookAndFeelDefaults():UIDefaults
		{
			checkLookAndFeel();
			return lookAndFeelDefaults;
		}
		
		private static function setLookAndFeelDefaults(d:UIDefaults):void
		{
			lookAndFeelDefaults = d;
		}
		
		private static function checkLookAndFeel():void
		{
			if(lookAndFeel == null){
				setLookAndFeel(new LookAndFeel());
			}
		}
		
		public static function containsKey(key:String):Boolean
		{
			return getDefaults().containsKey(key);
		}
		
		public static function get(key:String):*
		{
			return getDefaults().get(key);
		}
		
		public static function getBoolean(key:String):Boolean
		{
			return getDefaults().getBoolean(key);
		}
		
		public static function getNumber(key:String):Number
		{
			return getDefaults().getNumber(key);
		}
		
		public static function getInt(key:String):int
		{
			return getDefaults().getInt(key);
		}
		
		public static function getUint(key:String):uint
		{
			return getDefaults().getUint(key);
		}
		
		public static function getString(key:String):String
		{
			return getDefaults().getString(key);
		}
		
		public static function getColor(key:String):FColor
		{
			return getDefaults().getColor(key);
		}
		
		public static function getFont(key:String):FFont
		{
			return getDefaults().getFont(key);
		}
		
		public static function getDecorator(key:String):IDecorator
		{
			return getDefaults().getDecorator(key);
		}
		
		public static function getInstance(key:String):*
		{
			return getDefaults().getInstance(key);
		}
		
		public static function getClass(key:String):Class
		{
			return getDefaults().getConstructor(key);
		}
	}
}