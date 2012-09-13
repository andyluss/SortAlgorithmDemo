package
{

/**
 * @author lushisang
 * 
 * Bubble Sort Algorithm.
 */
public class BubbleSort
{
    public var processData:Array = [];
    
    public function compare(a:Number, b:Number):Number
    {
        return a - b;
    }

    public function swap(list:Array, i:int, j:int):void
    {
        var temp:Number;
        temp = list[i];
        list[i] = list[j];
        list[j] = temp;
    }

    public function sort(list:Array):Array
    {
        processData = [];
        var swapped:Boolean;
        
        for (var i:int = 0; i < list.length; i++)
        {
            for (var j:int = 0; j < list.length - i - 1; j++)
            {
                swapped = false;
                if (compare(list[j], list[j + 1]) > 0)
                {
                    swap(list, j, j + 1);
                    swapped = true;
                }
                
                // Save sort process data.
                processData.push({compareIndexes: [j, j + 1], swapped: swapped}); 
            }
        }
        return list;
    }
}
}