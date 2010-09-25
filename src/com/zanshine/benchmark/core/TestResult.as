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

    public final class TestResult
	{
		private var _className:String;
		public function get className():String
		{
			return _className; 
        }

        private var _methodName:String;
		public function get methodName():String
		{
			return _methodName;
		}
		
		private var _message:String;
		public function get message():String
		{
			return _message;
		}
		
		private var _iterationCount:int;
		public function get iterationCount():int
		{
			return _iterationCount;
		}
		
		private var _runCount:int;
		public function get runCount():int
		{
			return _runCount;
		}
		
		private var _delay:int;
		public function get delay():int
		{
			return _delay;
		}

		private var _duration:Number;
		public function set duration(value:Number):void
		{
            _duration = value;
		}
		public function get duration():Number
		{
			return _duration;
		}

        public function TestResult(   className	    :String,
									  methodName	:String,
									  message		:String,
									  iterationCount:int,
									  runCount	    :int,
									  delay		    :int):void
		{
			_className 		= className;
			_methodName 	= methodName;
			_message 		= message;
			_iterationCount = iterationCount;
			_runCount 		= runCount;
            _delay			= delay;
        }
    }
}