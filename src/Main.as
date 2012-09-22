package
{
import flash.events.MouseEvent;

import starling.animation.DelayedCall;
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
    private var count:int = 20;
    private var list:Array = [];
    private var listView:Sprite;
    private var sortAlgo:BubbleSort;
    private var currentFrame:int = 0;
    private var bar1:Quad;
    private var bar2:Quad;
    private var delayCall:DelayedCall;

    public function Main()
    {
        super();
        initListView();
        initButtons();
        reset();
    }
    
    public function reset():void
    {
        bar1 && (bar1.color = 0, bar1.alpha = 1);
        bar2 && (bar2.color = 0, bar2.alpha = 1);
        delayCall && (Starling.juggler.remove(delayCall), delayCall == null);
        currentFrame = 0;
        
        // Init list data by random number.
        list = [];
        for (var n:int = 0; n < 20; n++) 
        {
            list.push(int(Math.random() * 500));
            listView.getChildAt(n).height = list[n];
        }
    }

    public function initListView():void
    {
        listView = new Sprite;
        addChild(listView);

        for (var i:int = 0; i < count; i++)
        {
            listView.addChild(new Quad(20, 100, 0)).x = i * 22;
        }
    }

    public function initButtons():void
    {
        var sortBtn:Button = new Button(Texture.fromColor(100, 50, 0xFFAAAAFF), 'Sort');
        addChild(sortBtn);
        sortBtn.x = listView.width + 30;
        sortBtn.y = 5;
        sortBtn.addEventListener(Event.TRIGGERED, sort);
        
        var resetBtn:Button = new Button(Texture.fromColor(100, 50, 0xFFFFAAAA), 'Reset');
        addChild(resetBtn);
        resetBtn.x = listView.width + 30;
        resetBtn.y = 60;
        resetBtn.addEventListener(Event.TRIGGERED, reset);
    }

    public function sort():void
    {
        sortAlgo = new BubbleSort;
        sortAlgo.sort(list);
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
            delayCall = Starling.juggler.delayCall(step, 0.2);
        }
        else
        {
            bar1 && (bar1.color = 0, bar1.alpha = 1);
            bar2 && (bar2.color = 0, bar2.alpha = 1);
        }
    }

}
}
