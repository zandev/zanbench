package mock
{
	public class CaseHasRunMock
	{
		public static const FIRST:Class = FirstBenchMock;
		public static const SECOND:Class = SecondBenchMock;
		public static const THIRD:Class = ThirdBenchMock;
	}
}

import com.zanshine.benchmark.core.BenchmarkCase;	

class FirstBenchMock extends BenchmarkCase
{
	public static var runned:Boolean = false;
	
	[Benchmark]
	public function aTest():void 
	{
		runned = true;
	}
}

class SecondBenchMock extends BenchmarkCase
{
	public static var runned:Boolean = false;
	
	[Benchmark]
	public function aTest():void 
	{
		runned = true;
	}
}

class ThirdBenchMock extends BenchmarkCase
{
	public static var runned:Boolean = false;
	
	[Benchmark]
	public function aTest():void 
	{
		runned = true;
	}
}