package faysite.view.demos
{
	import faysite.view.sections.ComponentsPanel;
	
	import flash.display.Sprite;
	
	import mm.fay.layout.BorderUI;
	import mm.fay.vo.Insets;
	import mm.fay.vo.IntGap;

	/**
	 * BorderUI Demo
	 * 
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class BorderUIDemo extends Sprite
	{
        public function BorderUIDemo()
		{
			var border:BorderUI = BorderUI.create(this);
			border.setSize(400, 400)
				.setBackgroundColor(ComponentsPanel.LAYOUT_ELEMNT_COLOR)
				.setBackgroundAlpha(0.2)
				.setGap(new IntGap(5, 5))
				.setPadding(new Insets(5, 5, 5, 5));
			
			var arrFun:Array = new Array(border.appendToEast, border.appendToWest, border.appendToSouth, border.appendToNorth, border.appendToCenter);
			
			for (var i:int=0; i<5; ++i) {
				var sprite:Sprite = new Sprite();
				sprite.graphics.beginFill(ComponentsPanel.LAYOUT_ELEMNT_COLOR, .5);
				sprite.graphics.drawRect(0, 0, 100, 100);
				arrFun[i](sprite);
			}
			
			border.refresh();
        }
    }
}