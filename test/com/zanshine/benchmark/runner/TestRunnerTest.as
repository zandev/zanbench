package com.zanshine.benchmark.runner
{
	import com.zanshine.benchmark.kind.BenchmarkEventKind;
	import com.zanshine.benchmark.core.Benchmarkable;
	
	import com.zanshine.benchmark.event.BenchmarkEvent;
	import net.digitalprimates.fluint.tests.TestCase;

	import mock.IterationsCountMock;

	
	

	import mx.utils.StringUtil;

	public class TestRunnerTest extends TestCase
	{
		private var helper:TestHelper;
		private var runMethod:TestMethodRunner;
		
		override protected function setUp():void
		{
			helper = new TestHelper();
		}
		
		public function testRunEndEventDispatching():void
		{
			runMethod = new TestMethodRunner(new Function);
			runMethod.addEventListener(BenchmarkEventKind.LOOP_RUNNED.uid, asyncHandler(helper.runEndHandler, 50));
			runMethod.run();
		}
		
		public function testBenchEndEventDispatching():void
		{
			runMethod = new TestMethodRunner(new Function);
			runMethod.addEventListener(BenchmarkEventKind.TEST_RUNNED.uid, asyncHandler(helper.runEndHandler, 50));
			runMethod.run();
		}
		
		/**
		 * 
		 */
		private var rMethod:TestMethodRunner = new TestMethodRunner(new Function);
		public function testRunMethodPropertiesOnRunMethodEvent():void
		{
			rMethod.addEventListener(BenchmarkEventKind.LOOP_RUNNED.uid, asyncHandler(async_testRunMethodProperties, 50));
			rMethod.run();
		}
		
		private function async_testRunMethodProperties(event:BenchmarkEvent, data:Object):void
		{
			assertEquals(rMethod, event.target);
		}
		
		
		
		/**
		 * 
		 */
		public function testEventDispatchingCount():void
		{
			var executionTime:int = TestHelper.BENCH_COUNT * TestHelper.RUN_DELAY * 1.5;//be sure to be in bound time
			
			runMethod = new TestMethodRunner(new Function, TestHelper.METHOD_COUNT, TestHelper.BENCH_COUNT, TestHelper.RUN_DELAY);
			runMethod.addEventListener(BenchmarkEventKind.LOOP_RUNNED.uid, helper.runEndHandler);
			runMethod.addEventListener(BenchmarkEventKind.TEST_RUNNED.uid, asyncHandler(async_testEventDispatchingCount, executionTime));
			runMethod.run(); 
		}
		
		private function async_testEventDispatchingCount(event:BenchmarkEvent, data:Object):void 
		{ 
			assertEquals(TestHelper.BENCH_COUNT, helper.runEndCount);
		}
		
		
		
		/**
		 * 
		 */
		public function testRunMethodDelay():void
		{
			runMethod = new TestMethodRunner(new Function, 1, 1, TestHelper.RUN_DELAY);
			runMethod.addEventListener(BenchmarkEventKind.LOOP_RUNNED.uid, asyncHandler(async_testRunMethodDelay, 500));
			helper.startTimer();
			runMethod.run();
		}
		
		private function async_testRunMethodDelay(event:BenchmarkEvent, data:Object):void
		{
			var elapsedTime:Number = helper.elapsedTime;
			var message:String = "expected elapsed time to be more than {0}, but was {1}";
			assertTrue(
				StringUtil.substitute(message, TestHelper.RUN_DELAY, elapsedTime), 
				elapsedTime >= TestHelper.RUN_DELAY
			);
		}
		
		
		/**
		 * 
		 */
		public function testRunMethodCall():void
		{
			var benchTest:Benchmarkable = new IterationsCountMock();
			var itCountTest:IterationsCountMock = IterationsCountMock(benchTest);
			runMethod = new TestMethodRunner(itCountTest.benchMethod, TestHelper.METHOD_COUNT);
			runMethod.run();
			assertEquals(
				TestHelper.METHOD_COUNT, 
				itCountTest.methodCalls
			);
		}
	}
}

import com.zanshine.benchmark.event.BenchmarkEvent;
import net.digitalprimates.fluint.tests.TestCase;

import flash.utils.getTimer;

class TestHelper extends TestCase
{
	public static const RUN_DELAY:int = 250;
	public static const METHOD_COUNT:int = 13;
	public static const BENCH_COUNT:int = 7;
	
	private var _startTime:Number;
	public function startTimer():void
	{
		_startTime = getTimer();
	}
	
	public function get elapsedTime():Number
	{
		return getTimer() - _startTime;
	}
	
	public var runEndCount:int = 0;
	public function runEndHandler(event:BenchmarkEvent, data:Object = null):void { runEndCount++; }
}