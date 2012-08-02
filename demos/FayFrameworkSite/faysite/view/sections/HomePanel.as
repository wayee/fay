package faysite.view.sections
{
	import flash.display.DisplayObjectContainer;
	import mm.fay.FTextArea;

    public class HomePanel extends FTextArea
	{
        public function HomePanel(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
            super('', parent, x, y);
            setEditable(false);
			autoHideScrollBar = true;
            setHtmlText((("<p>Fay is a set of Flash-based User Interface Components written in ActionScript 3.0 by Andy Cai of <u><a href='https://github.com/wayee'>https://github.com/wayee</a></u>.</p>\n" + "<p>The key point is that these components are lightweight and extremely easy to use. They are ideal for web games. And they probably aren't what you want for a complex, data-driven enterprise site with a complex layout. But then again, they are a tiny, tiny fraction of the size, and have a tiny fraction of the learning curve of Flex components.</p>\n") + "<p>If you haven't guessed yet, this site is created purely with Fay Components. Personally, I'm not a huge proponent of all-Flash web sites, but in this case, I think it makes sense. if you don't have Flash installed, chances are you aren't even going to be here.</p>\n") + "<p>Fay is fully open source, with a very liberal MIT license. In other words, you can pretty much do whatever you want with them (read the license).</p>\n");
        }
    }
}