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
	import com.zanshine.benchmark.core.Benchmarkable;
    import com.zanshine.benchmark.utils.require;

    import flash.utils.describeType;

    internal final class BenchmarkCaseDescriptor
	{
				
		private var _tests:Array = [];
		
		public function get tests():Array
		{
			return _tests;
		}
		
		private var _className:String;
		
		public function get className():String
		{
			return _className;
		}

		public function BenchmarkCaseDescriptor(benchmarkCase:Benchmarkable)
		{
			require("benchmarkCase parameter can't be null", benchmarkCase != null);
			
			var describe:XML = describeType(benchmarkCase),
				methodList:XMLList = describe.method.(child('metadata').attribute('name') == 'Benchmark'),
				mDescriptor:TestMethodDescriptor;
				
			for each(var node:XML in methodList)
			{	
				var name:String 	= node.@name;
				var message:String 	= node.metadata.arg.(@key == 'message').@value;
				var func:Function 	= benchmarkCase[node.@name];
				var order:int 		= parseInt(node.metadata.arg.(@key == 'order').@value);
				//order have not be defined, or it have be defined with a wrong value;
				if(!(order > 0)) order = int.MAX_VALUE;
				
                mDescriptor = new TestMethodDescriptor(name, message, func, order);
				_tests.push(mDescriptor);
            }
			_className = describe.@name;
            _tests.sort(sortTest);
        }
        
        private function sortTest(a:TestMethodDescriptor, b:TestMethodDescriptor):Number
        {
        	if(a.order > b.order)
        	{
        		return 1;
        	}
        	else if (a.order < b.order)
        	{
        		return -1;
        	}
        	else
        	{
        		if(a.name > b.name)
        			return 1;
        		else if (a.name < b.name)
        			return -1;
        		else
        			return 0;
        	}
        }
    }
}