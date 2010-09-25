package com.zanshine.benchmark.runner 
{
	import com.zanshine.benchmark.kind.ResultEventKind;
	import com.zanshine.benchmark.kind.BenchmarkEventKind;
	import com.zanshine.benchmark.core.TestResult;
	
	import com.zanshine.benchmark.core.Benchmarkable;
    import mock.IterationsCountMock;
    import mock.LoudCaseMock;
    import mock.MethodsNamesCaseMock;
    import mock.SimpleCaseMock;

    import net.digitalprimates.fluint.sequence.SequenceCaller;
    import net.digitalprimates.fluint.sequence.SequenceRunner;
    import net.digitalprimates.fluint.sequence.SequenceWaiter;
    import net.digitalprimates.fluint.tests.TestCase;

    import com.zanshine.benchmark.event.BenchmarkEvent;

    import mx.rpc.events.ResultEvent;
    import mx.utils.StringUtil;

    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;

    public class CaseRunnerTest extends TestCase
	{
		private var benchTest:Benchmarkable;
		private var benchRunner:BenchmarkCaseRunner;
		
		private static const METHOD_COUNT:int = 5;
		private static const BENCH_COUNT:int = 3;
		private static const TOTAL_METHOD_COUNT:int = METHOD_COUNT * BENCH_COUNT;
		private static const DELAY:int = 50;
		
		override protected function setUp():void
		{
			benchTest = new MethodsNamesCaseMock();
			benchRunner = new BenchmarkCaseRunner(benchTest);
		}
		
		/**
		 * 
		 */
		public function testResultsLength():void
		{
			benchRunner.addEventListener(
				BenchmarkEventKind.CASE_RUNNED.uid, 
				asyncHandler(async_testResultsLength, 50)
			);
			benchRunner.run();
		}
		
		private function async_testResultsLength(event:BenchmarkEvent, data:Object):void
		{
			assertEquals(3, BenchmarkCaseRunner(event.target).results.length);			
		}
		
		/**
		 * 
		 */
		public function testMethodIterationCount():void
		{
			benchTest = new IterationsCountMock();
			benchRunner = new BenchmarkCaseRunner(benchTest, METHOD_COUNT);
			benchRunner.addEventListener(
				BenchmarkEventKind.CASE_RUNNED.uid, 
				asyncHandler(async_testMethodIterationCount, 50)
			);
			benchRunner.run();
		}
		
		private function async_testMethodIterationCount(event:BenchmarkEvent, data:Object):void
		{			
			assertEquals(
				METHOD_COUNT, 
				IterationsCountMock(benchTest).methodCalls
			);
		}
		
		/**
		 * 
		 */
		public function testBenchIterationCount():void
		{	
			benchTest = new IterationsCountMock();
			benchRunner = new BenchmarkCaseRunner(benchTest, METHOD_COUNT, BENCH_COUNT, DELAY);
			benchRunner.addEventListener(
				BenchmarkEventKind.CASE_RUNNED.uid, 
				asyncHandler(async_testBenchIterationCount, BENCH_COUNT * DELAY * 3.5)
			);
			benchRunner.run();
		}
		
		private function async_testBenchIterationCount(event:BenchmarkEvent, data:Object):void
		{			
			assertEquals(
				TOTAL_METHOD_COUNT, 
				IterationsCountMock(benchTest).methodCalls
			);
		}
		
		/**
		 * 
		 */
		public function testBenchMethodsCall():void
		{
			benchRunner.addEventListener(
				BenchmarkEventKind.CASE_RUNNED.uid, 
				asyncHandler(async_testBenchMethodsCall, 50)
			);
			benchRunner.run();
		}
		
		private function async_testBenchMethodsCall(event:BenchmarkEvent, data:Object):void
		{			
			assertEquals(3, MethodsNamesCaseMock(benchTest).runnedMethods.length);
		}
		
		/**
		 * 
		 */
		public function testResultsContainBenchResultObjects():void
		{
			benchRunner.addEventListener(
				BenchmarkEventKind.CASE_RUNNED.uid, 
				asyncHandler(async_testResultsContainBenchResultObjects, 50)
			);
			benchRunner.run();
		}
		
		private function async_testResultsContainBenchResultObjects(event:BenchmarkEvent, data:Object):void
		{			
			var message:String = "expected results to contain BenchResult objects but was {0}";
			var result:*;
			for each (result in BenchmarkCaseRunner(event.target).results)
			{
				assertTrue(
					StringUtil.substitute(message, getQualifiedClassName(result)), 
					result is TestResult
				);
			}
		}
		
		/**
		 * 
		 */
		public function testResultIsEmptyBeforeRunningBenchs():void
		{
			assertEquals(0, benchRunner.results.length);
		}
		
		/**
		 * 
		 */
		public function testResultPropertiesNonNullityAfterRunningBenchs():void
		{
			benchRunner.addEventListener(
				BenchmarkEventKind.CASE_RUNNED.uid, 
				asyncHandler(async_testResultPropertiesNonNullityAfterRunningBenchs,50)
			);
			benchRunner.run();
		}
		
		private function async_testResultPropertiesNonNullityAfterRunningBenchs(event:BenchmarkEvent, data:Object):void
		{
			var result:TestResult = benchRunner.results[0];
			assertTrue(result.className != null);
			assertTrue(result.methodName != null);
			assertTrue(result.message != null);
			assertFalse(isNaN(result.duration));
		}
		
		/**
		 * 
		 */
		public function testResultConsistency():void
		{
			benchTest = new SimpleCaseMock();
			benchRunner = new BenchmarkCaseRunner(benchTest);
			
			benchRunner.addEventListener(
				BenchmarkEventKind.CASE_RUNNED.uid, 
				asyncHandler(async_testResultConsistency, 50)
			);
			benchRunner.run();
		}
		
		private function async_testResultConsistency(event:BenchmarkEvent, data:Object):void
		{
			var result:TestResult = benchRunner.results[0];
			assertEquals(getQualifiedClassName(benchTest), result.className);
			assertEquals("benchMethod", result.methodName);			
			assertEquals(SimpleCaseMock.MESSAGE, result.message);
		}	
		
		public function testResultDurationShouldBeDifferentOnDifferentResults():void
		{
			benchTest = new LoudCaseMock();
			benchRunner = new BenchmarkCaseRunner(benchTest);
			benchRunner.run();
			
			var r1:TestResult,
				r2:TestResult,
				message:String = "Results should have different durations, " + 
								 "expected {0} to be different of {1}";
								 
			for each (r1 in benchRunner.results)
			{
				for each (r2 in benchRunner.results)
				{
					if(r1 != r2)
					{
						assertTrue(
							StringUtil.substitute(message, r1.duration, r2.duration), 
							r1.duration != r2.duration
						);	
					}
				}
			}
		}
		
		public function testResultsShouldHaveIncrementalDuration():void
		{
			benchTest = new LoudCaseMock();
			benchRunner = new BenchmarkCaseRunner(benchTest);
			benchRunner.addEventListener(
				BenchmarkEventKind.CASE_RUNNED.uid, 
				asyncHandler(async_testResultsShouldHaveIncrementalDuration, 500)
			);
			benchRunner.run();
		}
		
		private function async_testResultsShouldHaveIncrementalDuration(event:BenchmarkEvent, data:Object):void
		{
			var r:TestResult,
				d:Dictionary = new Dictionary();
			for each(r in BenchmarkCaseRunner(event.target).results)
			{
				d[r.methodName] = r.duration;
			}
			
			assertTrue(d[LoudCaseMock.VERY_FAST_TEST] < d[LoudCaseMock.FAST_TEST]);
			assertTrue(d[LoudCaseMock.FAST_TEST] < d[LoudCaseMock.MEDIUM_TEST]);
			assertTrue(d[LoudCaseMock.MEDIUM_TEST] < d[LoudCaseMock.SLOW_TEST]);
		}
		
		/**
		 * Test that the benchRunner dispatch correct events.
		 */
		 
		public function testDispatchTestMethodEndEvent():void
		{
			benchRunner.addEventListener(
				BenchmarkEventKind.TEST_RUNNED.uid, 
				asyncHandler(new Function, 50)
			);
			benchRunner.run();
		}
		
		public function testDispatchBenchTestEndEvent():void
		{
			benchRunner.addEventListener(
				BenchmarkEventKind.CASE_RUNNED.uid, 
				asyncHandler(new Function, 50)
			);
			benchRunner.run();
		}
		
		public function testDispatchResultEvent():void
		{
			benchRunner.addEventListener(
				ResultEventKind.RESULT.uid,
				asyncHandler(new Function, 50)
			);
			benchRunner.run();
		}
		 
		/**
		 * 
		 * Test that the benchRunner dispatch the correct number of event during the live cycle of the test.
		 * 
		 */
		public function testTestMethodEndEventCount():void
		{
			benchRunner.addEventListener(BenchmarkEventKind.TEST_RUNNED.uid, onTestMethodEnd);
			benchRunner.addEventListener(BenchmarkEventKind.CASE_RUNNED.uid, asyncHandler(async_testTestMethodEndEventCount, 50) );
			benchRunner.run();
		}
		
		private var testMethodEndEventCount:int = 0;
		private function onTestMethodEnd(event:BenchmarkEvent):void
		{
			testMethodEndEventCount++;
		}
		
		private function async_testTestMethodEndEventCount(event:BenchmarkEvent, data:Object):void
		{
			assertEquals(MethodsNamesCaseMock.METHODS_COUNT, testMethodEndEventCount);
		}
		
		
		/**
		  * The tests methods MUST be run in BenchmarkRunner one after each other.
		 */
		
		private var countMock:Mock = new Mock();
		public function testSequencedRunOfTestMethods() : void
		{
			var cRunner:BenchmarkCaseRunner = new BenchmarkCaseRunner(countMock);
			
			var sequence:SequenceRunner = new SequenceRunner(this);
			
			sequence.addStep(new SequenceWaiter(cRunner, ResultEventKind.RESULT.uid, 50));
			sequence.addStep(new SequenceCaller(this, assertFirstStep));
			
			sequence.addStep(new SequenceWaiter(cRunner, ResultEventKind.RESULT.uid, 50));
			sequence.addStep(new SequenceCaller(this, assertSecondStep));
			
			sequence.addStep(new SequenceWaiter(cRunner, ResultEventKind.RESULT.uid, 50));
			sequence.addAssertHandler(assertThirdStep, {});
			
			sequence.run();
			cRunner.run();
		}
		
		private function assertFirstStep():void
		{
			assertEquals(1, countMock.count);
		}

		private function assertSecondStep():void
		{
			assertEquals(2, countMock.count);
		}

		private function assertThirdStep(event:*, data:*):void
		{
			assertEquals(3, countMock.count);
		}
    }
}

import com.zanshine.benchmark.core.BenchmarkCase;

class Mock extends BenchmarkCase
{
	public var count:int = 0;
	
	public var firstMethodRunned:Boolean;
	[Benchmark]
	public function firstMethod():void
	{
		if(!firstMethodRunned)
		{
			count++;
			firstMethodRunned = true;
		}
	}

	public var secondMethodRunned:Boolean;
	[Benchmark]
	public function secondMethod():void
	{
		if(!secondMethodRunned)
		{
			count++;			
			secondMethodRunned = true;
		}
	}

	public var thirdMethodRunned:Boolean;
	[Benchmark]
	public function thirdMethod():void
	{
		if(!thirdMethodRunned)
		{
			count++;			
			thirdMethodRunned = true;
		}
	}
}