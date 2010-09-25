package mock
{
	import com.zanshine.benchmark.core.BenchmarkCase;
	
	public class SimpleCaseMock extends BenchmarkCase
	{	
		public static const MESSAGE:String = "azerty";
		public static const ORDER:int = 32;
		
		[Benchmark(message="azerty", order=32)]
		public function benchMethod():void { }
	}
}