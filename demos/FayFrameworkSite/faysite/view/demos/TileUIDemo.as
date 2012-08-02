package faysite.view.demos
{
	import faysite.view.sections.ComponentsPanel;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mm.fay.FButton;
	import mm.fay.layout.TileUI;
	import mm.fay.vo.Insets;
	import mm.fay.vo.IntGap;

	/**
	 * TileUI Demo
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class TileUIDemo extends Sprite
	{
		private var _btnTopLeft:FButton;
		private var _btnTopRight:FButton;
		private var _btnBottomLeft:FButton;
		private var _btnBottomRight:FButton;
		private var _btnHorizontal:FButton;
		private var _btnVertical:FButton;
		
		private var _tile:TileUI;
		
        public function TileUIDemo()
		{
			_btnTopLeft = new FButton('Top Left');
			_btnTopRight = new FButton('Top Right');
			_btnBottomLeft = new FButton('Bottom Left');
			_btnBottomRight = new FButton('Bottom Right');
			_btnHorizontal = new FButton('Horizontal');
			_btnVertical = new FButton('Vertical');
			
			var hbox:TileUI = TileUI.create(this);
			hbox.setSize(420, 48)
				.setGap(new IntGap(5, 5));
			hbox.addChild(_btnTopLeft);
			hbox.addChild(_btnTopRight);
			hbox.addChild(_btnBottomLeft);
			hbox.addChild(_btnBottomRight);
			hbox.addChild(_btnHorizontal);
			hbox.addChild(_btnVertical);
			hbox.refresh();
			
			hbox.addEventListener(MouseEvent.CLICK, __onClick);
			
			_tile = TileUI.create(this);
			_tile.setDirection(TileUI.DIRECTION_HORIZONTAL)
				.setSize(400, 300)
				.setBackgroundColor(ComponentsPanel.LAYOUT_ELEMNT_COLOR)
				.setBackgroundAlpha(0.2)
				.setGap(new IntGap(5, 5))
				.setPadding(new Insets(5, 5, 5, 5))
				.setAlign(TileUI.ALIGN_BOTTOM_RIGHT)
				.y = 48;
			
			for (var i:int=0; i<16; ++i) {
				var sprite:Sprite = new Sprite();
				sprite.graphics.beginFill(ComponentsPanel.LAYOUT_ELEMNT_COLOR, .5);
				sprite.graphics.drawRect(0, 0, 50, 50);
				_tile.addChild(sprite);
			}
			
			_tile.refresh();
        }

		private function __onClick(event:MouseEvent):void
		{
			var target:FButton = FButton(event.target);
			
			switch (target) {
				case _btnTopLeft:
					_tile.setAlign(TileUI.ALIGN_TOP_LEFT);
					_tile.refresh();
					break;
				case _btnTopRight:
					_tile.setAlign(TileUI.ALIGN_TOP_RIGHT);
					_tile.refresh();
					break;
				case _btnBottomLeft:
					_tile.setAlign(TileUI.ALIGN_BOTTOM_LEFT);
					_tile.refresh();
					break;
				case _btnBottomRight:
					_tile.setAlign(TileUI.ALIGN_BOTTOM_RIGHT);
					_tile.refresh();
					break;
				case _btnHorizontal:
					_tile.setDirection(TileUI.DIRECTION_HORIZONTAL);
					_tile.refresh();
					break;
				case _btnVertical:
					_tile.setDirection(TileUI.DIRECTION_VERTICAL);
					_tile.refresh();
					break;
			}
		}
    }
}