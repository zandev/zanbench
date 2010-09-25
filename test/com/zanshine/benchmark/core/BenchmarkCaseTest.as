package com.zanshine.benchmark.core 
{
	
    import net.digitalprimates.fluint.sequence.SequenceRunner;
    import net.digitalprimates.fluint.sequence.SequenceWaiter;
    import net.digitalprimates.fluint.tests.TestCase;

    import mock.BenchmarkableMock;
    import mock.PerMethodCallBackMock;
    import mock.WellOrderedMock;

    

    public class BenchmarkCaseTest extends TestCase
	{
		private var benchSuite:BenchmarkSuite;

		/**
		 * Generic callbacks ordering
		 */
		private var apiCallBenchCase:BenchmarkableMock;
		public function testAPICallOrdering():void
		{
			apiCallBenchCase = new BenchmarkableMock();
			benchSuite = new BenchmarkSuite();
			benchSuite.addBenchmark(apiCallBenchCase);
			
			var seq:SequenceRunner = new SequenceRunner(this);
			
			seq.addStep(new SequenceWaiter(apiCallBenchCase, BenchmarkableMock.PREPARE, 50, prepareTimeOut));
			seq.addStep(new SequenceWaiter(apiCallBenchCase, BenchmarkableMock.SET_UP, 50, firstSetupTimeOut));
			seq.addStep(new SequenceWaiter(apiCallBenchCase, BenchmarkableMock.METHOD, 50, firstMethodTimeOut));
			seq.addStep(new SequenceWaiter(apiCallBenchCase, BenchmarkableMock.TEAR_DOWN, 50, firstTearDownTimeOut));
			seq.addStep(new SequenceWaiter(apiCallBenchCase, BenchmarkableMock.SET_UP, 50, secondSetupTimeOut));
			seq.addStep(new SequenceWaiter(apiCallBenchCase, BenchmarkableMock.METHOD, 50, secondMethodTimeOut));
			seq.addStep(new SequenceWaiter(apiCallBenchCase, BenchmarkableMock.TEAR_DOWN, 50, secondTearDownTimeOut));
			seq.addStep(new SequenceWaiter(apiCallBenchCase, BenchmarkableMock.CLEAN, 50, cleanTimeOut));
			seq.run();
			benchSuite.run();
		}

		private function prepareTimeOut(arg:*):void
		{
			fail('prepare() failed');
		}
		
		private function firstSetupTimeOut(arg:*):void
		{
			fail('first setup() failed');
		}
		
		private function firstMethodTimeOut(arg:*):void
		{
			fail('first method() failed');
		}
		
		private function firstTearDownTimeOut(arg:*):void
		{
			fail('first tearDown() failed');
		}
		
		private function secondSetupTimeOut(arg:*):void
		{
			fail('second setup() failed');
		}
		
		private function secondMethodTimeOut(arg:*):void
		{
			fail('second method() failed');
		}
		
		private function secondTearDownTimeOut(arg:*):void
		{
			fail('second tearDown() failed');
		}
		
		private function cleanTimeOut(arg:*):void
		{
			fail('clean() failed');
		}
		
		/**
		  * Per methods callback
		  */
		  
		private var perMethodsBenchCase:PerMethodCallBackMock;
		public function testPerMethodsCallback():void
		{
			perMethodsBenchCase = new PerMethodCallBackMock();
			benchSuite = new BenchmarkSuite();
			benchSuite.addBenchmark(perMethodsBenchCase);
			
			var seq:SequenceRunner = new SequenceRunner(this);
			
			seq.addStep( new SequenceWaiter(perMethodsBenchCase, PerMethodCallBackMock.BEFORE_A_TEST_METHOD, 50, beforeATimeOut) );
			seq.addStep( new SequenceWaiter(perMethodsBenchCase, PerMethodCallBackMock.A_TEST_METHOD, 50, aTimeOut) );
			seq.addStep( new SequenceWaiter(perMethodsBenchCase, PerMethodCallBackMock.AFTER_A_TEST_METHOD, 50, afterATimeOut) );
			
			seq.addStep( new SequenceWaiter(perMethodsBenchCase, PerMethodCallBackMock.BEFORE_B_TEST_METHOD, 50, beforeBTimeOut) );
			seq.addStep( new SequenceWaiter(perMethodsBenchCase, PerMethodCallBackMock.B_TEST_METHOD, 50, bTimeOut) );
			seq.addStep( new SequenceWaiter(perMethodsBenchCase, PerMethodCallBackMock.AFTER_B_TEST_METHOD, 50, afterBTimeOut) );
			
			seq.run();
			benchSuite.run();
        }
        
        private function beforeATimeOut(arg:*):void
        {
            fail("beforeATestMethod failed");
        }
        
        private function aTimeOut(arg:*):void
        {
        	fail("aTestMethod failed"); 
        }
        
        private function afterATimeOut(arg:*):void
        {
        	fail("afterATestMethod failed"); 
        }
        
        private function beforeBTimeOut(arg:*):void
        {
        	 fail("beforeBTestMethod failed");
        }
        
        private function bTimeOut(arg:*):void
        {
        	 fail("bTestMethod failed");
        }
        
        private function afterBTimeOut(arg:*):void
        {
        	 fail("afterBTestMethod failed");
        }
        
        /**
         * Tesing method ordering with metatag argument : [Benchmarkable(order=1)]
         */
		private var orderedMock:WellOrderedMock;        
        public function testMethodsOrdering():void
        {
        	orderedMock = new WellOrderedMock();
			benchSuite = new BenchmarkSuite();
			benchSuite.addBenchmark(orderedMock);
			
			var seq:SequenceRunner = new SequenceRunner(this);
			
			seq.addStep( new SequenceWaiter(orderedMock, WellOrderedMock.B_METHOD, 50, failMethodOrderingB) );
			seq.addStep( new SequenceWaiter(orderedMock, WellOrderedMock.C_METHOD, 50, failMethodOrderingC) );
			seq.addStep( new SequenceWaiter(orderedMock, WellOrderedMock.D_METHOD, 50, failMethodOrderingD) );
			seq.addStep( new SequenceWaiter(orderedMock, WellOrderedMock.A_METHOD, 50, failMethodOrderingA) );
			
			seq.run();
			benchSuite.run();
        }
        
        private function failMethodOrderingA(arg:*):void
        {
        	fail("A_METHOD event expected");
        }
        
        private function failMethodOrderingB(arg:*):void
        {
        	fail("B_METHOD event expected");
        }
        
        private function failMethodOrderingC(arg:*):void
        {
        	fail("C_METHOD event expected");
        }
        
        private function failMethodOrderingD(arg:*):void
        {
        	fail("D_METHOD event expected");
        }
	}
}