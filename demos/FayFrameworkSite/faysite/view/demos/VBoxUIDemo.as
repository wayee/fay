package faysite.view.demos
{
	import faysite.view.sections.ComponentsPanel;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mm.fay.FButton;
	import mm.fay.layout.TileUI;
	import mm.fay.layout.VBoxUI;
	import mm.fay.vo.Insets;
	import mm.fay.vo.IntGap;

	/**
	 * VBoxUI Demo
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class VBoxUIDemo extends Sprite
	{
		private var _btnTopLeft:FButton;
		private var _btnTopRight:FButton;
		private var _btnTopCenter:FButton;
		private var _btnBottomLeft:FButton;
		private var _btnBottomRight:FButton;
		private var _btnBottomCenter:FButton;
		
		private var _vbox:VBoxUI;
		
        public function VBoxUIDemo()
		{
			_btnTopLeft = new FButton('Top Left');
			_btnTopRight = new FButton('Top Right');
			_btnTopCenter = new FButton('Top Center');
			_btnBottomLeft = new FButton('Bottom Left');
			_btnBottomRight = new FButton('Bottom Right');
			_btnBottomCenter = new FButton('Bottom Center');
			
			var hbox:TileUI = TileUI.create(this);
			hbox.setSize(420, 48)
				.setGap(new IntGap(5, 5));
			hbox.addChild(_btnTopLeft);
			hbox.addChild(_btnTopRight);
			hbox.addChild(_btnTopCenter);
			hbox.addChild(_btnBottomLeft);
			hbox.addChild(_btnBottomRight);
			hbox.addChild(_btnBottomCenter);
			hbox.refresh();
			
			hbox.addEventListener(MouseEvent.CLICK, __onClick);
			
			_vbox = VBoxUI.create(this);
			_vbox.setSize(400, 300)
				.setBackgroundColor(ComponentsPanel.LAYOUT_ELEMNT_COLOR)
				.setBackgroundAlpha(0.2)
				.setGap(new IntGap(5, 5))
				.setPadding(new Insets(5, 5, 5, 5))
				.setAlign(VBoxUI.ALIGN_BOTTOM_RIGHT)
				.y = 48;
			
			for (var i:int=0; i<8; ++i) {
				var sprite:Sprite = new Sprite();
				sprite.graphics.beginFill(ComponentsPanel.LAYOUT_ELEMNT_COLOR, .5);
				sprite.graphics.drawRect(0, 0, 40, 40);
				_vbox.addChild(sprite);
			}
			
			_vbox.refresh();
        }
		
		private function __onClick(event:MouseEvent):void
		{
			var target:FButton = FButton(event.target);
			
			switch (target) {
				case _btnTopLeft:
					_vbox.setAlign(VBoxUI.ALIGN_TOP_LEFT);
					_vbox.refresh();
					break;
				case _btnTopRight:
					_vbox.setAlign(VBoxUI.ALIGN_TOP_RIGHT);
					_vbox.refresh();
					break;
				case _btnTopCenter:
					_vbox.setAlign(VBoxUI.ALIGN_TOP_CENTER);
					_vbox.refresh();
					break;
				case _btnBottomLeft:
					_vbox.setAlign(VBoxUI.ALIGN_BOTTOM_LEFT);
					_vbox.refresh();
					break;
				case _btnBottomRight:
					_vbox.setAlign(VBoxUI.ALIGN_BOTTOM_RIGHT);
					_vbox.refresh();
					break;
				case _btnBottomCenter:
					_vbox.setAlign(VBoxUI.ALIGN_BOTTOM_CENTER);
					_vbox.refresh();
					break;
			}
		}
    }
}