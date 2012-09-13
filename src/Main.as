package
{
import flash.events.MouseEvent;

import starling.core.Starling;
import starling.display.Button;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

/**
 * @author lushisang
 */
public class Main extends Sprite
{
    private var list:Array =
        [100, 200, 200, 200, 300, 300, 100, 400, 400, 200,
        300, 300, 150, 200, 130, 300, 110, 213, 124, 21];
    private var listView:Sprite;
    private var sortAlgo:BubbleSort;
    private var currentFrame:int = 0;
    private var bar1:Quad;
    private var bar2:Quad;

    public function Main()
    {
        super();
        initListView();
        initButton();
    }

    public function initListView():void
    {
        listView = new Sprite;
        addChild(listView);

        var rect:Quad;
        for (var i:int = 0; i < list.length; i++)
        {
            rect = drawBar(i, 100, 0);
            rect.height = list[i];
            listView.addChild(rect);
        }
    }

    public function initButton():void
    {
        var btn:Button = new Button(Texture.fromColor(100, 50, 0xFFAAAAFF), 'Sort');
        addChild(btn);
        btn.x = listView.width + 30;
        btn.y = 5;
        btn.addEventListener(Event.TRIGGERED, sort);
    }

    public function sort(... rest):void
    {
        sortAlgo = new BubbleSort;
        sortAlgo.sort(list);
        playAnimation();
    }

    public function playAnimation():void
    {
        step();
    }

    public function step():void
    {
        var data:Object = sortAlgo.processData[currentFrame];
        bar1 && (bar1.color = 0, bar1.alpha = 1);
        bar2 && (bar2.color = 0, bar2.alpha = 1);
        bar1 = listView.getChildAt(data.compareIndexes[0]) as Quad;
        bar2 = listView.getChildAt(data.compareIndexes[1]) as Quad;
        bar1.color = 0xAAAAAA;
        bar2.color = 0xAAAAFF;
        if (data.swapped)
        {
            var tempBarHeight:Number = bar1.height;
            bar1.height = bar2.height;
            bar2.height = tempBarHeight;
            bar1.alpha = 0.5;
            bar2.alpha = 0.5;
        }
        if (currentFrame < sortAlgo.processData.length - 1)
        {
            currentFrame++;
            Starling.juggler.delayCall(step, 0.2);
        }
        else
        {
            bar1 && (bar1.color = 0, bar1.alpha = 1);
            bar2 && (bar2.color = 0, bar2.alpha = 1);
        }
    }

    public function drawBar(index:int, value:Number, color:uint):Quad
    {
        var rect:Quad = new Quad(20, value, color);
        rect.x = index * 22;
        addChild(rect);
        return rect;
    }
}
}
