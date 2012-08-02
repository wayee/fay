package faysite.view.demos
{
	import faysite.view.sections.ComponentsPanel;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mm.fay.FButton;
	import mm.fay.layout.HBoxUI;
	import mm.fay.layout.SoftBoxUI;
	import mm.fay.vo.Insets;
	import mm.fay.vo.IntGap;
	import mm.wit.utils.Fun;

	/**
	 * SoftBoxUI Demo
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class SoftBoxUIDemo extends Sprite
	{
		private var _btnHorizontal:FButton;
		private var _btnVertical:FButton;
		
		private var _softbox:SoftBoxUI;
		
        public function SoftBoxUIDemo()
		{
			_btnHorizontal = new FButton('Horizontal');
			_btnVertical = new FButton('Vertical');
			
			var hbox:HBoxUI = HBoxUI.create(this);
			hbox.setSize(420, 48)
				.setGap(new IntGap(5, 5));
			hbox.addChild(_btnHorizontal);
			hbox.addChild(_btnVertical);
			hbox.refresh();
			
			hbox.addEventListener(MouseEvent.CLICK, __onClick);
			
			_softbox = SoftBoxUI.create(this);
			_softbox.setSize(400, 300)
				.setBackgroundColor(ComponentsPanel.LAYOUT_ELEMNT_COLOR)
				.setBackgroundAlpha(0.2)
				.setGap(new IntGap(5, 5))
				.setPadding(new Insets(5, 5, 5, 5))
				.y = 24;
			
			for (var i:int=0; i<8; ++i) {
				var sprite:Sprite = new Sprite();
				sprite.graphics.beginFill(ComponentsPanel.LAYOUT_ELEMNT_COLOR, .5);
				sprite.graphics.drawRect(0, 0, 50, 50);
				_softbox.addChild(sprite);
			}
			
			_softbox.refresh();
        }
		
		private function __onClick(event:MouseEvent):void
		{
			var target:FButton = FButton(event.target);
			
			switch (target) {
				case _btnHorizontal:
					_softbox.axis = SoftBoxUI.X_AXIS;
					clearChildren();
					_softbox.refresh();
					break;
				case _btnVertical:
					_softbox.axis = SoftBoxUI.Y_AXIS;
					clearChildren();
					_softbox.refresh();
					break;
			}
		}
		
		private function clearChildren():void
		{
			Fun.clearChildren(_softbox);
			
			for (var i:int=0; i<8; ++i) {
				var sprite:Sprite = new Sprite();
				sprite.graphics.beginFill(ComponentsPanel.LAYOUT_ELEMNT_COLOR, .5);
				sprite.graphics.drawRect(0, 0, 50, 50);
				_softbox.addChild(sprite);
			}
		}
    }
}