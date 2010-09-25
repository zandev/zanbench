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
 package com.zanshine.benchmark.print
{
	import com.zanshine.benchmark.core.TestResult;
    import com.zanshine.benchmark.utils.require;

    internal final class TracePrinterTarget implements PrinterTarget
	{
		public function print(result:TestResult):void
		{
			require("result parameter can't be null", result != null);
			
			var a:Array, p:String = "";

			a = [
					toField(TraceTargetPrinterTokens.CLASS_NAME , result.className),
					toField(TraceTargetPrinterTokens.METHOD 	, result.methodName),
					toField(TraceTargetPrinterTokens.MESSAGE 	, result.message),
					toField(TraceTargetPrinterTokens.ITERATIONS , result.iterationCount),
					toField(TraceTargetPrinterTokens.RUNS 		, result.runCount),
					toField(TraceTargetPrinterTokens.DELAY		, result.delay),
					toField(TraceTargetPrinterTokens.DURATION 	, result.duration)
				];
			
			p = a.join(TraceTargetPrinterTokens.FIELD_END_DELIMITER) + "\n\n";
			_output += p;
			trace(p);
		}
		
		private var _output:String = "";
		public function get output():String
		{
			return _output;
		}
		
		private function toField(key:String, value:*):String
		{
			return key + TraceTargetPrinterTokens.LABEL_END_DELIMITER + value;
		}
	}
}