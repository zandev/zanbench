package mock
{
	import flash.events.EventDispatcher;
	import com.zanshine.benchmark.core.BenchmarkCase;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class BenchmarkableMock extends BenchmarkCase implements IEventDispatcher
	{
		public static const PREPARE:String = 'prepare';
		override public function prepare():void
		{
			dispatchEvent(new Event(PREPARE));
		}
		
		public static const SET_UP:String = 'setUp';
		override public function setUp():void
		{
			dispatchEvent(new Event(SET_UP));
		}
		
		/**
		 *  Benchmarks methods
		 */
		 
		public static const METHOD:String = 'method';
		
		[Benchmark]
		public function firstBenchmarkTest():void
		{
			dispatchEvent(new Event(METHOD));
		}
		
		[Benchmark]
		public function secondBenchmarkTest():void
		{
			dispatchEvent(new Event(METHOD));
		}
		
		/**
		 * 
		 */
		 
		public static const TEAR_DOWN:String = 'tearDown';
		override public function tearDown():void
		{
			dispatchEvent(new Event(TEAR_DOWN));
		}
		
		public static const CLEAN:String = 'clean'; 
		override public function clean():void
		{
			dispatchEvent(new Event(CLEAN));
		}
	}
}