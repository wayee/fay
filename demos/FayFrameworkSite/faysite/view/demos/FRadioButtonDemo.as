package faysite.view.demos
{
	import flash.display.Sprite;
	
	import mm.fay.FItemGroup;
	import mm.fay.FLabel;
	import mm.fay.FRadioButton;
	import mm.fay.layout.VBoxUI;

	/**
	 * FRadioButton Demo
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FRadioButtonDemo extends Sprite
	{
        public function FRadioButtonDemo()
		{
            new FLabel("Group A", this, 0, 0);
            var vbox1:VBoxUI = VBoxUI.create(this);
			vbox1.setSize(120, 80)
				.y = 24;
			var g1:FItemGroup = new FItemGroup;
			g1.append(new FRadioButton("Option 1", vbox1, 0, 0));
			g1.append(new FRadioButton("Option 2", vbox1, 0, 0));
			g1.append(new FRadioButton("Option 3", vbox1, 0, 0));
			g1.append(new FRadioButton("Option 4", vbox1, 0, 0));
			g1.setSelectedByIndex(0);
			
            new FLabel("Group B", this, 150, 0).setSize(220, 20);
            var vbox2:VBoxUI = VBoxUI.create(this);
			vbox2.setSize(100, 60);
			vbox2.x = 160;
			vbox2.y = 24;
			
			var g2:FItemGroup = new FItemGroup;
			g2.append(new FRadioButton("Choice 1", vbox2, 0, 0));
			g2.append(new FRadioButton("Choice 2", vbox2, 0, 0));
			g2.append(new FRadioButton("Choice 3", vbox2, 0, 0));
			g2.setSelectedByIndex(0);
        }
    }
}