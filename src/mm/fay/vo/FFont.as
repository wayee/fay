package mm.fay.vo
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import mm.fay.util.FUtil;
	
	/**
	 * Font that specified the font name, size, style and whether or not embed.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class FFont
	{
		private var name:String;
		private var size:uint;
		private var bold:Boolean;
		private var italic:Boolean;
		private var underline:Boolean;
		private var textFormat:TextFormat;
		
		public function FFont(name:String="Tahoma", size:Number=11, bold:Boolean=false, 
							  italic:Boolean=false, underline:Boolean=false)
		{
			this.name = name;
			this.size = size;
			this.bold = bold;
			this.italic = italic;
			this.underline = underline;
			textFormat = getTextFormat();
		}
		
		public function getName():String
		{
			return name;
		}
		
		public function changeName(name:String):FFont
		{
			return new FFont(name, size, bold, italic, underline);
		}
		
		public function getSize():uint
		{
			return size;
		}
		
		public function changeSize(size:int):FFont
		{
			return new FFont(name, size, bold, italic, underline);
		}
		
		public function isBold():Boolean
		{
			return bold;
		}
		
		public function changeBold(bold:Boolean):FFont
		{
			return new FFont(name, size, bold, italic, underline);
		}
		
		public function isItalic():Boolean
		{
			return italic;
		}
		
		public function changeItalic(italic:Boolean):FFont
		{
			return new FFont(name, size, bold, italic, underline);
		}
		
		public function isUnderline():Boolean
		{
			return underline;
		}
		
		public function changeUnderline(underline:Boolean):FFont
		{
			return new FFont(name, size, bold, italic, underline);
		}
		
//		public function isEmbedFonts():Boolean
//		{
//			return advancedProperties.isEmbedFonts();
//		}
		
		/**
		 * Applys the font to the specified text field.
		 * @param textField the text filed to be applied font.
		 * @param beginIndex The zero-based index position specifying the first character of the desired range of text. 
		 * @param endIndex The zero-based index position specifying the last character of the desired range of text. 
		 */
		public function apply(textField:TextField, beginIndex:int=-1, endIndex:int=-1):void
		{
//			advancedProperties.apply(textField);
			textField.setTextFormat(textFormat, beginIndex, endIndex);
			textField.defaultTextFormat = textFormat;
		}
		
		/**
		 * Return a new text format that contains the font properties.
		 * @return a new text format.
		 */
		public function getTextFormat():TextFormat
		{
			return new TextFormat(
				name, size, null, bold, italic, underline, 
				"", "", TextFormatAlign.LEFT, 0, 0, 0, 0 
			);
		}
		
		/**
		 * Computes text size with this font.
		 * @param text the text to be compute
		 * @includeGutters whether or not include the 2-pixels gutters in the result
		 * @return the computed size of the text
		 * @see mm.Fay.Futil#computeStringSizeWithFont
		 */
		public function computeTextSize(text:String, includeGutters:Boolean=true):IntDimension
		{
			return FUtil.computeStringSizeWithFont(this, text, includeGutters);
		}
		
		public function clone():FFont
		{
			return new FFont(name, size, bold, italic, underline);
		}	
		
		public function toString():String
		{
			return "FFont[" 
				+ "name : " + name 
				+ ", size : " + size 
				+ ", bold : " + bold 
				+ ", italic : " + italic 
				+ ", underline : " + underline 
				+ "]";
		}
	}
}