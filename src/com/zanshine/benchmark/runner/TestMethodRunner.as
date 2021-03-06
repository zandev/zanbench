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
	import com.zanshine.benchmark.kind.BenchmarkEventKind;
    import com.zanshine.benchmark.event.BenchmarkEvent;
    import com.zanshine.benchmark.lang.Runnable;
    import com.zanshine.benchmark.utils.ensure;
    import com.zanshine.benchmark.utils.require;

    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    import flash.utils.getTimer;

    internal final class TestMethodRunner extends EventDispatcher implements Runnable
	{
		private var delay:int,
					iterationCount:int,
					runCount:int,
					method:Function;
		
		public function TestMethodRunner(method:Function, iterationCount:int = 1, runCount:int = 1, delay:int = 0)
		{
			require("method parameter can't be null", method != null);
			require("iterationCount must be >= 1", 	  iterationCount >= 1);
			require("runCount must be >= 1", 		  runCount >= 1);
			require("delay argument must be >= 0", 	  delay >= 0);
			this.method 		= method;
			this.iterationCount = iterationCount;
			this.runCount	 	= runCount;
			this.delay 		 	= delay;
		}
		
		private var _duration:int;
		public function get duration():int
		{
			return _duration;
		}
		
		private var timer:Timer;
		
		public function run():void
		{
			var before:Number = getTimer();
			for(var i:int = 0; i < iterationCount; i++ )
			{
				method();
			}
			var after:Number = getTimer();
			_duration += after - before;
			
			timer = new Timer(delay, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, runEndHandler);
			timer.start();
			
			ensure("duration must be a number", !isNaN(duration));
		}
		
		private var runnedCount:int;
		private function runEndHandler(event:TimerEvent):void
		{
			runnedCount++;
			dispatchEvent(new BenchmarkEvent(BenchmarkEventKind.LOOP_RUNNED));
			if(runnedCount == runCount)
			{				
				dispatchEvent(new BenchmarkEvent(BenchmarkEventKind.TEST_RUNNED));
			}		
			else
			{				
				run();
			}
		}

	}
}