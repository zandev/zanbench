package mock 
{
    import com.zanshine.benchmark.core.BenchmarkCase;

    import flash.events.*;

    public class BadOrderedMock extends BenchmarkCase 
    {
    	
    	public static const EXPECTED_ORDER:Array = [B_METHOD, A_METHOD, C_METHOD, D_METHOD];
    	
        public static const A_METHOD:String = "aMethod";
    	[Benchmark]
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
    	[Benchmark]
    	public function dMethod():void
    	{
    		dispatchEvent(new Event(D_METHOD));
    	}
    	
    	public static const C_METHOD:String = "cMethod";
    	[Benchmark]
    	public function cMethod():void
    	{
    		dispatchEvent(new Event(C_METHOD));
    	}
    }
}
