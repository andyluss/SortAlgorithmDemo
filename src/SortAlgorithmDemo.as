package
{
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.system.Security;

import starling.core.Starling;


/**
 * @author lushisang
 */	
[SWF(width="600", height="500", frameRate="60")]
public class SortAlgorithmDemo extends Sprite
{
    private var iStarling:Starling;
    private var mainView:Main;
    
    public function SortAlgorithmDemo()
    {
        Security.allowDomain('*');
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        
        iStarling = new Starling(Main, stage);
        iStarling.start();
    }
    
}
}