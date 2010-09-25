package mock 
{
	import flash.events.*;
	import com.zanshine.benchmark.core.BenchmarkCase;
	
    public class PerMethodCallBackMock extends BenchmarkCase implements IEventDispatcher
    {
    	
    	/**
    	 * 
    	 */
    	public static const BEFORE_A_TEST_METHOD:String = "beforeATestMethod";
    	public function beforeATestMethod():void
    	{
    		dispatchEvent(new Event(BEFORE_A_TEST_METHOD));
        }
    	
    	public static const A_TEST_METHOD:String = "ATestMethod";
    	[Benchmark]
    	public function aTestMethod():void
    	{
    		dispatchEvent(new Event(A_TEST_METHOD));
    	}
    	
    	public static const AFTER_A_TEST_METHOD:String = "afterATestMethod";
    	public function afterATestMethod():void
    	{
    		dispatchEvent(new Event(AFTER_A_TEST_METHOD));
        }
    	
    	/**
    	 * 
    	 */
    	public static const BEFORE_B_TEST_METHOD:String = "beforeBTestMethod";
    	public function beforeBTestMethod():void
    	{
    		dispatchEvent(new Event(BEFORE_B_TEST_METHOD));
    	}
    	
    	public static const B_TEST_METHOD:String = "bTestMethod";
    	[Benchmark]
    	public function bTestMethod():void
    	{
    		dispatchEvent(new Event(B_TEST_METHOD));
    	}
    	
    	public static const AFTER_B_TEST_METHOD:String = "afterBTestMethod";
    	public function afterBTestMethod():void
    	{
    		dispatchEvent(new Event(AFTER_B_TEST_METHOD));
        }
    }
}
