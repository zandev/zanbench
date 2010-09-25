package mock 
{
	import flash.events.*;
    import com.zanshine.benchmark.core.BenchmarkCase;

    public class WellOrderedMock extends BenchmarkCase implements IEventDispatcher
    {
    	public static const EXPECTED_ORDER:Array = [B_METHOD, C_METHOD, D_METHOD, A_METHOD];
    	
    	
        public static const A_METHOD:String = "aMethod";
    	[Benchmark(order=3)]
    	public function aMethod():void
    	{
    		dispatchEvent(new Event(A_METHOD));
        }
    	
    	public static const B_METHOD:String = "bMethod";
    	[Benchmark(order=1)]
    	public function bMethod():void
    	{
    		dispatchEvent(new Event(B_METHOD));
    	}
    	
    	public static const D_METHOD:String = "dMethod";
    	[Benchmark(order=2)]
    	public function dMethod():void
    	{
    		dispatchEvent(new Event(D_METHOD));
    	}
    	
    	public static const C_METHOD:String = "cMethod";
    	[Benchmark(order=2)]
    	public function cMethod():void
    	{
    		dispatchEvent(new Event(C_METHOD));
    	}
    }
}
