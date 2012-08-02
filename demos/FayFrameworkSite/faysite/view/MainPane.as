package faysite.view
{
	import faysite.view.sections.ComponentsPanel;
	import faysite.view.sections.HomePanel;
	
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.getDefinitionByName;
	
	import mm.fay.FItemGroup;
	import mm.fay.FLabel;
	import mm.fay.FPanel;
	import mm.fay.FToggleButton;
	import mm.fay.basic.AbstractButton;
	import mm.fay.layout.VBoxUI;
	import mm.fay.vo.IntGap;
	
	public class MainPane extends Sprite
	{
		private var menu:FPanel;
		private var content:FPanel;
		private var sectionNames:Array;
		private var currentSection:String = "Home";
		
		public var menuVBox:VBoxUI;
		
		public function MainPane()
		{
			super();
			
			this.sectionNames = ["Home", "Components", "Download"];
		}
		
		public function initialize():void
		{
			var tmpButton:FToggleButton;
			var titleLabel:FLabel = new FLabel("Fay UI Framework", this, 10, 10);
			titleLabel.setSize(300, 20);
			titleLabel.scaleX = (titleLabel.scaleY = 2);
			this.menu = new FPanel(this, 10, 50);
			this.menu.setSize(110, (stage.stageHeight - 60));
			menuVBox = VBoxUI.create(this.menu.content);
			menuVBox.setSize(10, 10)
					.setGap(new IntGap(5, 5));
			var index:int;
			var group:FItemGroup = new FItemGroup;
			while (index < this.sectionNames.length) {
				tmpButton = new FToggleButton(this.sectionNames[index], menuVBox, 0, 0);
				tmpButton.width = 90;
				tmpButton.data = index;
				group.append(tmpButton);
				index++;
			}
			menuVBox.refresh();
			
			this.content = new FPanel(this, 130, 50);
			this.content.setSize((stage.stageWidth - 140), (stage.stageHeight - 60));
			this.makeSection((menuVBox.getChildAt(0) as FToggleButton));
			group.setSelected((menuVBox.getChildAt(0) as FToggleButton), true);
		}
		
		public function sectionChosen(btn:AbstractButton):void
		{
			var title:String = this.sectionNames[btn.data];
			if (title != this.currentSection) {
				this.makeSection(btn as FToggleButton);
				this.currentSection = title;
			}
		}
		
		protected function makeSection(btn:FToggleButton):void
		{
			var classRef:Class = null;
			var section:* = null;
			var button:FToggleButton = btn;
			var index:int = int(button.data);
			if (index == 2){
				navigateToURL(new URLRequest("https://github.com/wayee"), "_blank");
				return;
			}
			while (this.content.content.numChildren > 0) {
				this.content.content.removeChildAt(0);
			}
			try {
				classRef = (getDefinitionByName((("faysite.view.sections." + this.sectionNames[index]) + "Panel")) as Class);
				section = new classRef(this.content.content, 10, 10);
				section.setSize((this.content.width - 20), (this.content.height - 20));
			} catch(e:Error) {
			}
		}
		
		HomePanel;
		ComponentsPanel;
	}
}