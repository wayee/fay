package faysite.view.demos
{
	import faysite.view.sections.ComponentsPanel;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mm.fay.FButton;
	import mm.fay.layout.HBoxUI;
	import mm.fay.layout.TileUI;
	import mm.fay.vo.Insets;
	import mm.fay.vo.IntGap;

	/**
	 * HBoxUI Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class HBoxUIDemo extends Sprite
	{
		private var _btnTopLeft:FButton;
		private var _btnCenterLeft:FButton;
		private var _btnBottomLeft:FButton;
		private var _btnTopRight:FButton;
		private var _btnCenterRight:FButton;
		private var _btnBottomRight:FButton;
		
		private var _hbox:HBoxUI;
		
        public function HBoxUIDemo()
		{
			_btnTopLeft = new FButton('Top Left');
			_btnCenterLeft = new FButton('Center Left');
			_btnBottomLeft = new FButton('Bottom Left');
			_btnTopRight = new FButton('Top Right');
			_btnCenterRight = new FButton('Center Right');
			_btnBottomRight = new FButton('Bottom Right');
			
			var hbox:TileUI = TileUI.create(this);
			hbox.setSize(420, 48)
				.setGap(new IntGap(5, 5));
			hbox.addChild(_btnTopLeft);
			hbox.addChild(_btnCenterLeft);
			hbox.addChild(_btnBottomLeft);
			hbox.addChild(_btnTopRight);
			hbox.addChild(_btnCenterRight);
			hbox.addChild(_btnBottomRight);
			hbox.refresh();
			
			hbox.addEventListener(MouseEvent.CLICK, __onClick);
			
			_hbox = HBoxUI.create(this);
			_hbox.setSize(400, 300)
				.setBackgroundColor(ComponentsPanel.LAYOUT_ELEMNT_COLOR)
				.setBackgroundAlpha(0.2)
				.setGap(new IntGap(5, 5))
				.setPadding(new Insets(5, 5, 5, 5))
				.setAlign(HBoxUI.ALIGN_BOTTOM_RIGHT)
				.y = 48;
			
			for (var i:int=0; i<8; ++i) {
				var sprite:Sprite = new Sprite();
				sprite.graphics.beginFill(ComponentsPanel.LAYOUT_ELEMNT_COLOR, .5);
				sprite.graphics.drawRect(0, 0, 40, 40);
				_hbox.addChild(sprite);
			}
			
			_hbox.refresh();
        }
		
		private function __onClick(event:MouseEvent):void
		{
			var target:FButton = FButton(event.target);
			
			switch (target) {
				case _btnTopLeft:
					_hbox.setAlign(HBoxUI.ALIGN_TOP_LEFT);
					_hbox.refresh();
					break;
				case _btnCenterLeft:
					_hbox.setAlign(HBoxUI.ALIGN_CENTER_LEFT);
					_hbox.refresh();
					break;
				case _btnBottomLeft:
					_hbox.setAlign(HBoxUI.ALIGN_BOTTOM_LEFT);
					_hbox.refresh();
					break;
				case _btnTopRight:
					_hbox.setAlign(HBoxUI.ALIGN_TOP_RIGHT);
					_hbox.refresh();
					break;
				case _btnCenterRight:
					_hbox.setAlign(HBoxUI.ALIGN_CENTER_RIGHT);
					_hbox.refresh();
					break;
				case _btnBottomRight:
					_hbox.setAlign(HBoxUI.ALIGN_BOTTOM_RIGHT);
					_hbox.refresh();
					break;
			}
		}
    }
}