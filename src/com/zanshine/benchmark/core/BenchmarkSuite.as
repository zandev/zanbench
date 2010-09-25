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
package com.zanshine.benchmark.core
{

    import com.zanshine.benchmark.event.BenchmarkEvent;
    import com.zanshine.benchmark.event.ResultEvent;
    import com.zanshine.benchmark.kind.BenchmarkEventKind;
    import com.zanshine.benchmark.kind.ResultEventKind;
    import com.zanshine.benchmark.lang.Runnable;
    import com.zanshine.benchmark.runner.BenchmarkCaseRunner;
    import com.zanshine.benchmark.utils.require;

    import flash.events.EventDispatcher;

    public final class BenchmarkSuite extends EventDispatcher implements Runnable
	{
		
		public function addBenchmark(benchmarkCase:Benchmarkable, iterationCount:int = 1, runCount:int = 1, delay:int = 0):void
		{
			require("benchmarkCaser argument can't be null", benchmarkCase != null);
			require("iterationCount argument must be >= 1",   iterationCount >= 1);
			require("runCount argument must be >= 1",         runCount >= 1);
			require("delay argument must be >= 0", 			  delay >= 0);
			
            var runner:BenchmarkCaseRunner = new BenchmarkCaseRunner(benchmarkCase, iterationCount, runCount, delay);
			runner.addEventListener(BenchmarkEventKind.CASE_RUNNED.uid, benchTestEndHandler);
			runner.addEventListener(ResultEventKind.RESULT.uid, methodResultHandler);
			runners.push(runner);
		}
		
		private var runners:Array = [];
		public function run():void
		{
			var r:BenchmarkCaseRunner = runners.shift();
			r.run();
		}
		
		
		private function benchTestEndHandler(event:BenchmarkEvent):void
		{
			if(runners.length == 0)
			{
				var results:Array = [],
					run:BenchmarkCaseRunner,
					res:TestResult;
				/**
				 * Deprecated
				 */
				for each(run in runners)
				{
					for each(res in run.results) 
						results.push(res); 
				} 
				/**
				 * End
				 */
				dispatchEvent(new BenchmarkEvent(BenchmarkEventKind.SUITE_RUNNED/*, results*/));				
			}
			else
			{
				this.run();
			}
		}
		
		private function methodResultHandler(event:ResultEvent):void
		{
			dispatchEvent(new ResultEvent(ResultEventKind.RESULT, event.result));
		}
	}
}