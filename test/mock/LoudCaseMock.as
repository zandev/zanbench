package mock
{
	import com.zanshine.benchmark.core.BenchmarkCase;

	public class LoudCaseMock extends BenchmarkCase
	{
		public static const ITERATIONS_COUNT:int = 10000;
		public static const FAST_COEFICIENT:int = 8;
		public static const MEDIUM_COEFICIENT:int = 16;
		public static const SLOW_COEFICIENT:int = 32;
		
		private var i:int;
		
		public static const VERY_FAST_TEST:String = "veryFastTest";
		[Benchmark]
		public function veryFastTest():void
		{
			i = 0;
			var dummy:*;
			while(i++ < ITERATIONS_COUNT)
			{
				dummy = {};
			}
		}
		
		public static const FAST_TEST:String = "fastTest";
		[Benchmark]
		public function fastTest():void
		{
			i = 0;
			var dummy:*;
			while(i++ < ITERATIONS_COUNT * FAST_COEFICIENT)
			{
				dummy = {};
			}
		}
		
		public static const MEDIUM_TEST:String = "mediumTest";
		[Benchmark]
		public function mediumTest():void
		{
			i = 0;
			var dummy:*;
			while(i++ < ITERATIONS_COUNT * MEDIUM_COEFICIENT)
			{
				dummy = {};
			}
		}
		
		public static const SLOW_TEST:String = "slowTest";
		[Benchmark]
		public function slowTest():void
		{
			i = 0;
			var dummy:*;
			while(i++ < ITERATIONS_COUNT * SLOW_COEFICIENT)
			{
				dummy = {};
			}
		}
	}
}