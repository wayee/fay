package faysite.view.demos
{
	import faysite.view.sections.ComponentsPanel;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mm.fay.FButton;
	import mm.fay.layout.GridUI;
	import mm.fay.layout.TileUI;
	import mm.fay.vo.Insets;
	import mm.fay.vo.IntGap;

	/**
	 * GridUI Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class GridUIDemo extends Sprite
	{
		private var _btnTopLeft:FButton;
		private var _btnTopRight:FButton;
		private var _btnBottomLeft:FButton;
		private var _btnBottomRight:FButton;
		private var _btnHorizontal:FButton;
		private var _btnVertical:FButton;
		
		private var _grid:GridUI;
		
        public function GridUIDemo()
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
			hbox.addChilds(_btnTopLeft, _btnTopRight, _btnBottomLeft,
						_btnBottomRight, _btnHorizontal, _btnVertical
						);
			hbox.refresh();
			
			hbox.addEventListener(MouseEvent.CLICK, __onClick);
			
			_grid = GridUI.create(this, 400);
			_grid.setDirection(GridUI.DIRECTION_HORIZONTAL)
				.setSize(300, 50)
				.setBackgroundColor(ComponentsPanel.LAYOUT_ELEMNT_COLOR)
				.setBackgroundAlpha(0.2)
				.setGap(new IntGap(5, 5))
				.setPadding(new Insets(5, 5, 5, 5))
				.setAlign(GridUI.ALIGN_BOTTOM_RIGHT)
				.y = 48;
			
			for (var i:int=0; i<16; ++i) {
				var offset:int = i%2==0 ? Math.random()*10 : -Math.random()*10;
				var sprite:Sprite = new Sprite();
				sprite.graphics.beginFill(ComponentsPanel.LAYOUT_ELEMNT_COLOR, .5);
				sprite.graphics.drawRect(0, 0, 40 + offset, 40 + offset);
				sprite.graphics.endFill();
				_grid.addChild(sprite);
				
				sprite.graphics.lineStyle(1, 0xD9D9D9);
				sprite.graphics.drawRect(0, 0, 50, 50);
			}
			
			_grid.refresh();
        }
		
		private function __onClick(event:MouseEvent):void
		{
			var target:FButton = FButton(event.target);
			
			switch (target) {
				case _btnTopLeft:
					_grid.setAlign(GridUI.ALIGN_TOP_LEFT);
					_grid.refresh();
					break;
				case _btnTopRight:
					_grid.setAlign(GridUI.ALIGN_TOP_RIGHT);
					_grid.refresh();
					break;
				case _btnBottomLeft:
					_grid.setAlign(GridUI.ALIGN_BOTTOM_LEFT);
					_grid.refresh();
					break;
				case _btnBottomRight:
					_grid.setAlign(GridUI.ALIGN_BOTTOM_RIGHT);
					_grid.refresh();
					break;
				case _btnHorizontal:
					_grid.setDirection(GridUI.DIRECTION_HORIZONTAL);
					_grid.refresh();
					break;
				case _btnVertical:
					_grid.setDirection(GridUI.DIRECTION_VERTICAL);
					_grid.refresh();
					break;
			}
		}
    }
}