package faysite.view.demos
{
	import faysite.view.sections.ComponentsPanel;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mm.fay.FButton;
	import mm.fay.layout.HBoxUI;
	import mm.fay.layout.SolidBoxUI;
	import mm.fay.vo.Insets;
	import mm.fay.vo.IntGap;
	import mm.wit.utils.Fun;

	/**
	 * SolidBoxUI Demo
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class SolidBoxUIDemo extends Sprite
	{
		private var _btnHorizontal:FButton;
		private var _btnVertical:FButton;
		
		private var _solidbox:SolidBoxUI;
		
        public function SolidBoxUIDemo()
		{
			_btnHorizontal = new FButton('Horizontal');
			_btnVertical = new FButton('Vertical');
			
			var hbox:HBoxUI = HBoxUI.create(this);
			hbox.setSize( 420, 48)
				.setGap(new IntGap(5, 5));
			hbox.addChild(_btnHorizontal);
			hbox.addChild(_btnVertical);
			hbox.refresh();
			
			hbox.addEventListener(MouseEvent.CLICK, __onClick);
			
			_solidbox = SolidBoxUI.create(this)
			_solidbox.setSize(400, 300)
				.setBackgroundColor(ComponentsPanel.LAYOUT_ELEMNT_COLOR)
				.setBackgroundAlpha(0.2)
				.setGap(new IntGap(5, 5))
				.setPadding(new Insets(5, 5, 5, 5))
				.y = 24;
			
			for (var i:int=0; i<8; ++i) {
				var sprite:Sprite = new Sprite();
				sprite.graphics.beginFill(ComponentsPanel.LAYOUT_ELEMNT_COLOR, .5);
				sprite.graphics.drawRect(0, 0, 50, 50);
				_solidbox.addChild(sprite);
			}
			
			_solidbox.refresh();
        }
		
		private function __onClick(event:MouseEvent):void
		{
			var target:FButton = FButton(event.target);
			
			switch (target) {
				case _btnHorizontal:
					_solidbox.setAxis(SolidBoxUI.X_AXIS);
					clearChildren();
					_solidbox.refresh();
					break;
				case _btnVertical:
					_solidbox.setAxis(SolidBoxUI.Y_AXIS);
					clearChildren();
					_solidbox.refresh();
					break;
			}
		}
		
		private function clearChildren():void
		{
			Fun.clearChildren(_solidbox);
			
			for (var i:int=0; i<8; ++i) {
				var sprite:Sprite = new Sprite();
				sprite.graphics.beginFill(ComponentsPanel.LAYOUT_ELEMNT_COLOR, .5);
				sprite.graphics.drawRect(0, 0, 50, 50);
				_solidbox.addChild(sprite);
			}
		}
    }
}