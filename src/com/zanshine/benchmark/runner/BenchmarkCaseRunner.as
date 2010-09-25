/**
 * Copyright (C) 2009 Stéphane Robert Richard.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the project nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 * 
 */
 package com.zanshine.benchmark.runner
{
	import com.zanshine.benchmark.kind.ResultEventKind;
	import com.zanshine.benchmark.kind.BenchmarkEventKind;
    import com.zanshine.benchmark.core.Benchmarkable;
    import com.zanshine.benchmark.core.TestResult;
    import com.zanshine.benchmark.event.BenchmarkEvent;
    import com.zanshine.benchmark.event.ResultEvent;
    import com.zanshine.benchmark.lang.Runnable;
    import com.zanshine.benchmark.utils.require;

    import flash.events.EventDispatcher;
    import flash.utils.*;

    public final class BenchmarkCaseRunner extends EventDispatcher implements Runnable
	{
		private var benchmarkCase	:Benchmarkable,
					descriptor		:BenchmarkCaseDescriptor,
					iterationCount	:int,
					runCount		:int,
					delay			:int;

		public function BenchmarkCaseRunner(benchmarkCase:Benchmarkable, iterationCount:int = 1, runCount:int = 1, delay:int = 0)
		{
			require("benchmarkCase parameter can't be null", benchmarkCase 	!= null);
			require("iterationCount must be >= 1", 			 iterationCount >= 1);
			require("runCount must be >= 1", 				 runCount 		>= 1);
			require("delay argument must be >= 0", 			 delay 			>= 0);
			
			this.benchmarkCase  = benchmarkCase;
			this.iterationCount = iterationCount;
			this.runCount  		= runCount;
			this.delay 		 	= delay;
			
			descriptor = new BenchmarkCaseDescriptor(benchmarkCase);
			initTests();
		}
		
		private var pendingTests:Array;
		
		private function initTests():void
		{
			pendingTests = descriptor.tests.slice();
		}
		
		
		private var _results:Array = [];
		[Deprecated("Useless. Need to be removed, but a lot of tests are build on this property.")]
		public function get results():Array
		{
			return _results;
		}
		
		private var testsToResultsMap:Dictionary = new Dictionary();

		public function run():void
		{
			if(pendingTests.length == descriptor.tests.length) 
				benchmarkCase.prepare();
			
			var	testDesc	:TestMethodDescriptor = pendingTests.shift(),
				func		:Function  			= benchmarkCase[testDesc.name],
				testRun 	:TestMethodRunner 	= new TestMethodRunner(func, iterationCount, runCount, delay),
				result 		:TestResult 		= new TestResult(getQualifiedClassName(benchmarkCase), testDesc.name, testDesc.message, iterationCount, runCount, delay);
			
			testsToResultsMap[testRun] = result;
			
			//Callbacks :
			benchmarkCase.setUp();
			new BeforeCallBack(benchmarkCase, testDesc.name).execute();
            
            testRun.addEventListener(BenchmarkEventKind.TEST_RUNNED.uid, testRunnedHandler);
			testRun.run();
		}
		
		
		private function testRunnedHandler(event:BenchmarkEvent):void
		{
			var result:TestResult = testsToResultsMap[event.target];
			
			//release the memory :
			testsToResultsMap[event.target] = null;
			result.duration	  	   = TestMethodRunner(event.target).duration;
			results.push(result);
			
			//Callbacks :
			new AfterCallBack(benchmarkCase, result.methodName).execute();
            benchmarkCase.tearDown();
            
			dispatchEvent(new BenchmarkEvent(BenchmarkEventKind.TEST_RUNNED));
			dispatchEvent(new ResultEvent(ResultEventKind.RESULT, result));
			
			if(pendingTests.length == 0)
			{
				benchmarkCase.clean();
				dispatchEvent(new BenchmarkEvent(BenchmarkEventKind.CASE_RUNNED));
			}
			else
			{
				run();
			}
		}
	}
}