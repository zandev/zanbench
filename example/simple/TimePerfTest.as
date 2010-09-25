package simple 
{
    import flash.display.Sprite;
    import flash.utils.getTimer;
	/**
	 * 
	 * This class is an example of how you would implement a simple benchmark test without zanbench.
	 * 
	 */
    public class TimePerfTest extends Sprite
    {
        public function TimePerfTest()
        {
            measureGetTimer();
            measureDate();
        }

        public function measureGetTimer():void
        {
            var before:Number = getTimer();
            var whatTimeIsItPlease:Number;
            for (var i:int = 0;i < 1000000; i++)             
            {
                whatTimeIsItPlease = getTimer();
            }
            var after:Number = getTimer();
            trace(after - before);//1469
        }

        public function measureDate():void
        {
            var before:Number = getTimer();
            var whatTimeIsItPlease:Number;
            for (var i:int = 0;i < 1000000; i++)             
            {
                whatTimeIsItPlease = (new Date()).time;
            }
            var after:Number = getTimer();
            trace(after - before);//3728
        }
    }
}
