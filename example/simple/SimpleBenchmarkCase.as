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
 package simple 
{
    import com.zanshine.benchmark.core.BenchmarkCase;

    public class SimpleBenchmarkCase extends BenchmarkCase 
    {
    	/**
    	 * before callbacks
    	 */
    	override public function prepare():void
    	{
            comment("The prepare() method is called before any test run", "prepare");
    	}
    	
    	override public function setUp():void
    	{
            comment("Before each test, the setUp() method is called", "setUp");
    	}
    	
    	/**
    	 * First test method
    	 */
    	 
    	public function beforeFirstTestSimpleMethod():void
    	{
    		comment("You can define a before callback for any given method " +
    		"by simply use a \"before\" prefix with the method name camelized", "beforeFirstTestSimpleMethod"); 
    	}
    	
    	[Benchmark(order=2, message="This is a first simple test method")]
    	public function firstTestSimpleMethod():void
    	{
    		comment("This is the first test method (in order of class declaration). " +
    		"It is called after the second test method, because we've assigned it " +
    		"an order=2 in the Benchmark metadata tag. " +
    		"This method is where you put the code you want to benchmark. " +
    		"Accordingly to the arguments given to the addBenchmark method in the suite, " +
    		"this method will be called 4 times.", "firstTestSimpleMethod");
    	}
    	
    	public function afterFirstTestSimpleMethod():void
    	{
    		comment("You can define a before callback for any given method " +
    		"by simply use an \"after\" prefix with the method name camelized", "afterFirstTestSimpleMethod");
    	}

        /**
    	 * Second test method
    	 */
    	public function beforeSecondTestSimpleMethod():void
    	{
    		comment("You can define a before callback for any given method " +
    		"by simply use a \"before\" prefix with the method name camelized", "beforeSecondTestSimpleMethod");
    	}
    	
    	[Benchmark(order=1, message="This is a first simple test method")]
    	public function secondTestSimpleMethod():void
    	{
    		comment("This is the second test method (in order of class declaration). " +
    		"It is called after the second test method, because we've assigned it " +
    		"an order=2 in the Benchmark metadata tag. " +
    		"This method is where you put the code you want to benchmark. " +
    		"Accordingly to the arguments given to the addBenchmark method in the suite, " +
    		"this method will be called 4 times.", "secondTestSimpleMethod");
    	}
    	
    	public function afterSecondTestSimpleMethod():void
    	{
    		comment("You can define a before callback for any given method " +
    		"by simply use an \"after\" prefix with the method name camelized", "afterSecondTestSimpleMethod");
    	}
    	
    	/**
    	 * After callbacks
    	 */
    	 
    	override public function tearDown():void
    	{
    		comment("After each test, the tearDown() method is called", "tearDown");
    	}
    	
    	override public function clean():void
    	{
    		comment("The clean() method is called after all tests runs", "clean");
        }
    	
    	/**
    	 * Here is an helper method :
    	 */
    	
    	private function comment(string:String, method:String):void
        {
            trace("\n");
            trace("- ##### => " + method + "() called");
            trace("- " + string);
            trace("--------------------------------------------------------");
        }
    }
}
