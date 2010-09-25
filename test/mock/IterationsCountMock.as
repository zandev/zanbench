package mock 
{
	
	import com.zanshine.benchmark.core.BenchmarkCase;

	public class IterationsCountMock extends BenchmarkCase
	{
		
		public var methodCalls:int;
		
		[Benchmark]
		public function benchMethod():void
		{
			methodCalls++;
		}

	}
}