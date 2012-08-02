package mm.fay.laf
{
	import mm.fay.laf.decorator.BasicBackground;
	import mm.fay.laf.decorator.BasicIcon;
	import mm.fay.laf.decorator.ButtonIcon;
	import mm.fay.laf.decorator.ButtonStateObject;
	import mm.fay.laf.decorator.ScrollBarThumb;
	import mm.fay.laf.decorator.TextComponentBackground;
	import mm.fay.vo.FColor;
	import mm.fay.vo.FFont;
	import mm.fay.vo.Insets;
	
	/**
	 * Look and feel implement of components.
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class LookAndFeel
	{
		public function getDefaults():UIDefaults
		{
			var table:UIDefaults  = new UIDefaults();
			
			initSystemColorDefaults(table);
			initSystemFontDefaults(table);
			initComponentDefaults(table);
			
			return table;
		}
		
		/**
		 * Initailizes the color of components.
		 */
		protected function initSystemColorDefaults(table:UIDefaults):void
		{
			var defaultSystemColors:Array = [
				"window", 0xCACDCC,
				"windowText", 0xFFFFFF,
				"control", 0xF4F4F4,
				"controlText", 0x002a37			
			];
			
			for (var i:Number=0; i<defaultSystemColors.length; i+=2) {
				table.put(defaultSystemColors[i], new FColor(defaultSystemColors[i+1]));
			}
		}
		
		/**
		 * Initailizes the font of components.
		 */
		protected function initSystemFontDefaults(table:UIDefaults):void
		{
			var defaultSystemFonts:Array = [
				"systemFont", new FFont("Arial", 12), 
				"windowFont", new FFont("Arial", 12, true),
				"controlFont", new FFont("Arial", 12) 
			];
			
			table.putDefaults(defaultSystemFonts);
		}
		
		/**
		 * Initializes the default properties of all components. 
		 */
		protected function initComponentDefaults(table:UIDefaults):void
		{
			var comDefaults:Array;
			
			// Button
			comDefaults = [
				"Button.background", table.get("control"),
				"Button.foreground", table.get("controlText"),
				"Button.opaque", true,  
				"Button.font", table.getFont("controlFont"),
				"Button.backgroundDecorator", ButtonStateObject,
				"Button.defaultImage", Button_defaultImage,
				"Button.pressedImage", Button_pressedImage,
				"Button.rolloverImage", Button_rolloverImage,
				"Button.disabledImage", Button_disabledImage
//				"Button.textFilters", [new DropShadowFilter(1, 45, 0, 0.3, 1, 1, 1, 1)]
			];
			table.putDefaults(comDefaults);
			
			// ToggleButton
			comDefaults = [
				"ToggleButton.background", table.get('control'),
				"ToggleButton.foreground", table.get("controlText"), 
				"ToggleButton.opaque", true, 
				"ToggleButton.font", table.getFont("controlFont"),
				"ToggleButton.backgroundDecorator", ButtonStateObject,
				"ToggleButton.defaultImage", Button_defaultImage,
				"ToggleButton.pressedImage", Button_pressedImage,
				"ToggleButton.rolloverImage", Button_rolloverImage,
				"ToggleButton.disabledImage", Button_disabledImage,
				"ToggleButton.selectedImage", Button_pressedImage,
				"ToggleButton.rolloverSelectedImage", Button_pressedImage,
				"ToggleButton.disabledSelectedImage", Button_disabledImage
//				"ToggleButton.textFilters", [new DropShadowFilter(1, 45, 0, 0.3, 1, 1, 1, 1)]
			];
			table.putDefaults(comDefaults);
			
			// RadioButton
			comDefaults = [
				"RadioButton.background", table.get('control'),
				"RadioButton.foreground", table.get("controlText"), 
				"RadioButton.opaque", false,
				"RadioButton.iconDecorator", ButtonIcon,
				"RadioButton.font", table.getFont("controlFont"),
				"RadioButton.textShiftOffset", 10,
				"RadioButton.defaultImage", RadioButton_defaultImage,
				"RadioButton.pressedImage", RadioButton_pressedImage,
				"RadioButton.rolloverImage", RadioButton_rolloverImage,
				"RadioButton.disabledImage", RadioButton_disabledImage,
				"RadioButton.selectedImage", RadioButton_selectedImage,
				"RadioButton.pressedSelectedImage", RadioButton_pressedSelectedImage,
				"RadioButton.rolloverSelectedImage", RadioButton_rolloverSelectedImage,
				"RadioButton.disabledSelectedImage", RadioButton_disabledSelectedImage
			];
			table.putDefaults(comDefaults);
			
			// CheckBox
			comDefaults = [
				"CheckBox.background", table.get('control'),
				"CheckBox.foreground", table.get("controlText"), 
				"CheckBox.opaque", false,
				"CheckBox.iconDecorator", ButtonIcon,
				"CheckBox.font", table.getFont("controlFont"),
				"CheckBox.textShiftOffset", 10,
				"CheckBox.defaultImage", CheckBox_defaultImage,
				"CheckBox.pressedImage", CheckBox_pressedImage,
				"CheckBox.rolloverImage", CheckBox_rolloverImage,
				"CheckBox.disabledImage", CheckBox_disabledImage,
				"CheckBox.selectedImage", CheckBox_selectedImage,
				"CheckBox.pressedSelectedImage", CheckBox_pressedSelectedImage,
				"CheckBox.rolloverSelectedImage", CheckBox_rolloverSelectedImage,
				"CheckBox.disabledSelectedImage", CheckBox_disabledSelectedImage
			];
			table.putDefaults(comDefaults);
			
			// Label
			comDefaults = [
				"Label.background", table.get("control"),
				"Label.foreground", table.get("controlText"), 
				"Label.opaque", false, 
				"Label.font", table.getFont("controlFont"),
//				"Label.textFilters", [new DropShadowFilter(1, 45, 0, 0.3, 1, 1, 1, 1)]
			];
			table.putDefaults(comDefaults);
			
			// TextField
			comDefaults = [
				"TextField.background", table.get('control'),
				"TextField.foreground", table.get("controlText"), 
				"TextField.opaque", true, 
				"TextField.backgroundDecorator", TextComponentBackground,
				"TextField.font", table.getFont("controlFont"),
				"TextField.defaultImage", TextField_defaultImage,
				"TextField.uneditableImage", TextField_uneditableImage,
				"TextField.disabledImage", TextField_disabledImage
			];
			table.putDefaults(comDefaults);
			
			// TextArea
			comDefaults = [
				"TextArea.background", table.get('control'),
				"TextArea.foreground", table.get("controlText"), 
				"TextArea.opaque", true, 
				"TextArea.backgroundDecorator", TextComponentBackground,
				"TextArea.font", table.getFont("controlFont"),
				"TextArea.defaultImage", TextField_defaultImage,
				"TextArea.uneditableImage", TextField_uneditableImage,
				"TextArea.disabledImage", TextField_disabledImage
			];
			table.putDefaults(comDefaults);
			
			// Tooltip
			comDefaults = [
				"ToolTip.background", table.get('control'),
				"ToolTip.foreground", table.get("controlText"), 
				"ToolTip.opaque", true, 
				"ToolTip.font", table.getFont("controlFont"),
				"ToolTip.backgroundDecorator", BasicBackground,
				"ToolTip.padding", new Insets(4, 4, 4, 4),
				"ToolTip.bgImage", ToolTip_bgImage
			];
			table.putDefaults(comDefaults);
			
			// TabBar
			comDefaults = [
				"TabBar.background", table.get('control'),
				"TabBar.foreground", table.get("controlText"), 
				"TabBar.opaque", true, 
				"TabBar.font", table.getFont("controlFont")
			];
			table.putDefaults(comDefaults);
			
			// Panel
			comDefaults = [
				"Panel.background", table.get('control'),
				"Panel.foreground", table.get("controlText"), 
				"Panel.opaque", true, 
//				"Panel.backgroundDecorator", BasicBackground,
				"Panel.font", table.getFont("controlFont"),
				"Panel.bgImage", ToolTip_bgImage
			];
			table.putDefaults(comDefaults);
			
			// ScrollBar
			comDefaults = [
				"ScrollBar.opaque", true, 
				"ScrollBar.barWidth", 14, 
				"ScrollBar.thumbDecorator", ScrollBarThumb
			];
			table.putDefaults(comDefaults);
			
			// ProgressBar
			comDefaults = [
				"ProgressBar.padding", new Insets(1, 1, 1, 1), 
				"ProgressBar.horizotalBGImage", ProgressBar_horizotalBGImage, 
				"ProgressBar.horizotalFGImage", ProgressBar_horizotalFGImage
			];
			table.putDefaults(comDefaults);
			
			// Viewport
			comDefaults = [
				"Viewport.background", table.get("window"),
				"Viewport.foreground", table.get("windowText"), 
				"Viewport.opaque", false, 
				"Viewport.font", table.getFont("windowFont")
			];
			table.putDefaults(comDefaults);
			
			// Frame
			comDefaults = [
				"Frame.background", table.get('control'),
				"Frame.foreground", table.get("controlText"), 
				"Frame.opaque", true, 
				"Frame.font", table.getFont("windowFont"),
				"Frame.backgroundDecorator", BasicBackground,
				"Frame.closeIconWidth", 18,
				"Frame.closeIconHeight", 23,
				"Frame.closeIcon", ButtonStateObject,
				"Frame.closeIcon.defaultImage", Frame_closeIcon_defaultImage, 
				"Frame.closeIcon.pressedImage", Frame_closeIcon_pressedImage, 
				"Frame.closeIcon.disabledImage", Frame_closeIcon_disabledImage, 
				"Frame.closeIcon.rolloverImage", Frame_closeIcon_rolloverImage,
				"Frame.bgImage", ToolTip_bgImage
			];
			table.putDefaults(comDefaults);
			
			// FrameTitleBar
			comDefaults = [
				"FrameTitleBar.background", table.get("control"),
				"FrameTitleBar.foreground", table.get("controlText"),
				"FrameTitleBar.opaque", true,  
				"FrameTitleBar.font", table.getFont("windowFont"),
				"FrameTitleBar.titleBarHeight", 25
//				"Button.textFilters", [new DropShadowFilter(1, 45, 0, 0.3, 1, 1, 1, 1)]
			];
			table.putDefaults(comDefaults);
			
		}
		
		
		///////////////////////////////////
		// assets
		///////////////////////////////////
		
		///////////////////////////////////
		// Button
		///////////////////////////////////
		
		[Embed(source="assets/FayLAF.swf", symbol="Button_defaultImage")]
		private var Button_defaultImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="Button_pressedImage")]
		private var Button_pressedImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="Button_rolloverImage")]
		private var Button_rolloverImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="Button_disabledImage")]
		private var Button_disabledImage:Class;
		
		///////////////////////////////////
		// ToggleButton
		///////////////////////////////////
		
		///////////////////////////////////
		// CheckBox
		///////////////////////////////////
		
		[Embed(source="assets/FayLAF.swf", symbol="CheckBox_defaultImage")]
		private var CheckBox_defaultImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="CheckBox_pressedImage")]
		private var CheckBox_pressedImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="CheckBox_rolloverImage")]
		private var CheckBox_rolloverImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="CheckBox_disabledImage")]
		private var CheckBox_disabledImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="CheckBox_selectedImage")]
		private var CheckBox_selectedImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="CheckBox_pressedSelectedImage")]
		private var CheckBox_pressedSelectedImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="CheckBox_rolloverSelectedImage")]
		private var CheckBox_rolloverSelectedImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="CheckBox_disabledSelectedImage")]
		private var CheckBox_disabledSelectedImage:Class;
		
		///////////////////////////////////
		// RadioButton
		///////////////////////////////////
		
		[Embed(source="assets/FayLAF.swf", symbol="RadioButton_defaultImage")]
		private var RadioButton_defaultImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="RadioButton_pressedImage")]
		private var RadioButton_pressedImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="RadioButton_rolloverImage")]
		private var RadioButton_rolloverImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="RadioButton_disabledImage")]
		private var RadioButton_disabledImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="RadioButton_selectedImage")]
		private var RadioButton_selectedImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="RadioButton_pressedSelectedImage")]
		private var RadioButton_pressedSelectedImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="RadioButton_rolloverSelectedImage")]
		private var RadioButton_rolloverSelectedImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="RadioButton_disabledSelectedImage")]
		private var RadioButton_disabledSelectedImage:Class;
		
		///////////////////////////////////
		// TextField
		///////////////////////////////////
		
		[Embed(source="assets/FayLAF.swf", symbol="TextField_defaultImage")]
		private var TextField_defaultImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="TextField_uneditableImage")]
		private var TextField_uneditableImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="TextField_disabledImage")]
		private var TextField_disabledImage:Class;
		
		///////////////////////////////////
		// TextArea
		///////////////////////////////////
		
		///////////////////////////////////
		// ToolTip
		///////////////////////////////////
		
		[Embed(source="assets/FayLAF.swf", symbol="ToolTip_bgImage")]
		private var ToolTip_bgImage:Class;
		
		///////////////////////////////////
		// Panel
		///////////////////////////////////
		
		///////////////////////////////////
		// Frame
		///////////////////////////////////
		
		[Embed(source="assets/FayLAF.swf", symbol="Frame_closeIcon_defaultImage")]
		private var Frame_closeIcon_defaultImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="Frame_closeIcon_pressedImage")]
		private var Frame_closeIcon_pressedImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="Frame_closeIcon_disabledImage")]
		private var Frame_closeIcon_disabledImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="Frame_closeIcon_rolloverImage")]
		private var Frame_closeIcon_rolloverImage:Class;
		
		///////////////////////////////////
		// ProgressBar
		///////////////////////////////////
		
		[Embed(source="assets/FayLAF.swf", symbol="ProgressBar_horizotalBGImage")]
		private var ProgressBar_horizotalBGImage:Class;
		
		[Embed(source="assets/FayLAF.swf", symbol="ProgressBar_horizotalFGImage")]
		private var ProgressBar_horizotalFGImage:Class;
		
	}
}