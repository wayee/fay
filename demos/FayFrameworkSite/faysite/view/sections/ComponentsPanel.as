package faysite.view.sections
{
	import faysite.view.demos.BorderUIDemo;
	import faysite.view.demos.FButtonDemo;
	import faysite.view.demos.FCheckBoxDemo;
	import faysite.view.demos.FFrameDemo;
	import faysite.view.demos.FHSliderDemo;
	import faysite.view.demos.FLabelDemo;
	import faysite.view.demos.FOptionPaneDemo;
	import faysite.view.demos.FPanelDemo;
	import faysite.view.demos.FProgressBarDemo;
	import faysite.view.demos.FRadioButtonDemo;
	import faysite.view.demos.FSharedToolTipDemo;
	import faysite.view.demos.FStepperDemo;
	import faysite.view.demos.FTextAreaDemo;
	import faysite.view.demos.FTextFieldDemo;
	import faysite.view.demos.FVSliderDemo;
	import faysite.view.demos.GridUIDemo;
	import faysite.view.demos.HBoxUIDemo;
	import faysite.view.demos.SoftBoxUIDemo;
	import faysite.view.demos.SolidBoxUIDemo;
	import faysite.view.demos.TileUIDemo;
	import faysite.view.demos.VBoxUIDemo;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	import mm.fay.FItemGroup;
	import mm.fay.FLabel;
	import mm.fay.FToggleButton;
	import mm.fay.layout.VBoxUI;
	import mm.fay.vo.IntGap;

	/**
	 * Components Panel
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
	public class ComponentsPanel extends Sprite
	{
		public static const LAYOUT_ELEMNT_COLOR:uint = 0x0000FF;
		
		private var compNames:Array;
		private var demo:Sprite;
		private var demoLabel:FLabel;
		
		public function ComponentsPanel(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super();
			this.x = x;
			this.y = y;
			this.demoLabel = new FLabel('', this, 120, 0);
			this.demoLabel.setSize(200, 20);
			
			parent.addChild(this);
			
			addChildren();
		}
		
		protected function addChildren():void
		{
			var button:FToggleButton;
			this.compNames = ["FButton", "FRadioButton", "FCheckBox", "FTextField", "FTextArea", "FLabel", "FSharedToolTip", "FHSlider", "FVSlider", "FPanel", "FFrame", "FOptionPane", "FProgressBar", "FStepper", "HBoxUI", "VBoxUI", "TileUI", "GridUI", "SoftBoxUI", "SolidBoxUI", "BorderUI"];
			var vbox:VBoxUI = VBoxUI.create(this);
			vbox.setSize(100, 100)
				.setGap(new IntGap(4, 4));
			var group:FItemGroup = new FItemGroup;
			var index:int;
			while (index < this.compNames.length) {
				button = new FToggleButton(this.compNames[index], vbox, 0, 0);
				button.addEventListener(MouseEvent.CLICK, this.onBtnClick);
				button.data = index;
				group.append(button);
				index++;
			}
			vbox.refresh();
		}
		
		protected function onBtnClick(event:MouseEvent):void
		{
			var demoName:* = null;
			var classRef:Class = null;
			if (this.demo != null && contains(this.demo)) {
				removeChild(this.demo);
			}
			try {
				demoName = this.compNames[event.target.data];
				classRef = (getDefinitionByName((("faysite.view.demos." + demoName) + "Demo")) as Class);
				this.demo = new (classRef)();
				this.demo.x = 130;
				this.demo.y = 30;
				this.addChild(this.demo);
				this.demoLabel.setText(demoName + " Demo");
			} catch(e:Error) {
			}
		}
		
		FButtonDemo;
		FRadioButtonDemo;
		FCheckBoxDemo;
		FTextFieldDemo;
		FTextAreaDemo;
		FLabelDemo;
		FSharedToolTipDemo;
		FHSliderDemo;
		FVSliderDemo;
		FPanelDemo;
		FFrameDemo;
		FOptionPaneDemo;
		FProgressBarDemo;
		FStepperDemo;
		HBoxUIDemo;
		VBoxUIDemo;
		TileUIDemo;
		GridUIDemo;
		SoftBoxUIDemo;
		SolidBoxUIDemo;
		BorderUIDemo;
		
	}
}