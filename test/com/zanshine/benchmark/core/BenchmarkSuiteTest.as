package com.zanshine.benchmark.core
{
	import com.zanshine.benchmark.kind.ResultEventKind;
	import com.zanshine.benchmark.kind.BenchmarkEventKind;
	
	import net.digitalprimates.fluint.sequence.SequenceCaller;
	import net.digitalprimates.fluint.sequence.SequenceRunner;
	import net.digitalprimates.fluint.sequence.SequenceWaiter;
	import net.digitalprimates.fluint.tests.TestCase;

	import mock.SimpleCaseMock;

	
	import com.zanshine.benchmark.event.BenchmarkEvent;
	import mx.rpc.events.ResultEvent;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class BenchmarkSuiteTest extends TestCase
	{
		private var firstMock:FirstBenchMock;
		private var secondMock:SecondBenchMock;
		private var thirdMock:ThirdBenchMock;
		
		override protected function setUp():void
		{
			var mocks:Array = [FirstBenchMock, SecondBenchMock, ThirdBenchMock];
			for each(var o:* in mocks) 
			{
				o.runned = false;
				o.runnedCount = 0;
			}
			
			firstMock = new FirstBenchMock();
			secondMock = new SecondBenchMock();
			thirdMock = new ThirdBenchMock();
		}
		
		/**
		 * 
		 */
		private var timer:Timer;
		public function testShouldRunAllTests():void
		{	
			var suite:BenchmarkSuite = new BenchmarkSuite();
			suite.addBenchmark(firstMock);
			suite.addBenchmark(secondMock);
			suite.addBenchmark(thirdMock);
			suite.run();
			
			timer = new Timer(50, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, asyncHandler(async_testShouldRunAllTests, 60));
			timer.start();
		}
		
		private function async_testShouldRunAllTests(event:TimerEvent, data:Object):void
		{
			var message:String = 
				"All 3 BenchTest Classes should have run. " + 
				"Expected : [true && true && true] but was ";
				
			var resultString:String = 
				"[ " + 
					firstMock.runned  + " && " + 
					secondMock.runned + " && " +
					thirdMock.runned  + 
				"]";
			
			assertTrue( 
				message + resultString,
				firstMock.runned && 
				secondMock.runned && 
				thirdMock.runned
			);
		}
		
		
		/**
		 * 
		 */
		private var itCount:int = 13;
		private var rCount:int = 5;
		
		public function testDispatchSuiteRunnedEvent():void
		{
			var suite:BenchmarkSuite = new BenchmarkSuite();
			suite.addBenchmark(firstMock, itCount, rCount);
			suite.addBenchmark(secondMock, itCount, rCount);
			suite.addBenchmark(thirdMock, itCount, rCount);
			suite.addEventListener(BenchmarkEventKind.SUITE_RUNNED.uid, asyncHandler(async_testDispatchSuiteRunnedEvent, 50));
			
			suite.run();
		}
		
		private function async_testDispatchSuiteRunnedEvent(event:BenchmarkEvent, data:Object):void
		{
			var mocks:Array = [firstMock, secondMock, thirdMock];
			for each(var o:* in mocks) 
			{
				assertEquals(itCount * rCount, o.runnedCount);
			}
		}
		
		/**
		 * 
		 */
		 public function testDispatchMethodResultEvent():void
		 {
		 	var suite:BenchmarkSuite = new BenchmarkSuite();
			suite.addBenchmark(new SimpleCaseMock);
			suite.addEventListener(ResultEventKind.RESULT.uid, asyncHandler(new Function, 50));
			suite.run();
		 }
		 
		 /**
		  * The benchmarks MUST be run in BenchmarkSuite one after each other. 
		 */

		public function testSequencedRunOfCases() : void
		{
			var suite:BenchmarkSuite = new BenchmarkSuite();
			suite.addBenchmark(firstMock);
			suite.addBenchmark(secondMock);
			suite.addBenchmark(thirdMock);
			
			var sequence:SequenceRunner = new SequenceRunner(this);
			
			sequence.addStep(new SequenceWaiter(suite, ResultEventKind.RESULT.uid, 50));
			sequence.addStep(new SequenceCaller(this, assertFirstStep));
			
			sequence.addStep(new SequenceWaiter(suite, ResultEventKind.RESULT.uid, 50));
			sequence.addStep(new SequenceCaller(this, assertSecondStep));
			
			sequence.addStep(new SequenceWaiter(suite, ResultEventKind.RESULT.uid, 50));
			sequence.addAssertHandler(assertThirdStep, {});
			
			sequence.run();
			suite.run();
		}
		
		private function assertFirstStep():void
		{
			assertTrue("expected firstMock == true", firstMock.runned);
			assertFalse("expected secondMock == false", secondMock.runned);
			assertFalse("expected thirdMock == false", thirdMock.runned);
		}
		
		private function assertSecondStep():void
		{
			assertTrue("expected firstMock == true", firstMock.runned);
			assertTrue("expected secondMock == true", secondMock.runned);
			assertFalse("expected thirdMock == false", thirdMock.runned);
		}
		
		private function assertThirdStep(event:*, data:*):void
		{
			assertTrue("expected firstMock == true", firstMock.runned);
			assertTrue("expected secondMock == true", secondMock.runned);
			assertTrue("expected thirdMock == true", thirdMock.runned);
		}
	}
}

import com.zanshine.benchmark.core.BenchmarkCase;

class Mock extends BenchmarkCase
{
	public var runned:Boolean;
	
	public var runnedCount:int = 0;
	
	[Benchmark]
	public function aTest():void 
	{
		runned = true;
		runnedCount++;
	}
}

class FirstBenchMock  extends Mock { }

class SecondBenchMock extends Mock { }

class ThirdBenchMock  extends Mock { }
		
		
		