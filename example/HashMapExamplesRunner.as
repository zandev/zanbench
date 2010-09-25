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
package
{
	import com.zanshine.benchmark.core.BenchmarkSuite;
	import com.zanshine.benchmark.print.ResultPrinter;

    import hashmap.*;

    import flash.display.Sprite;
	
	public class HashMapExamplesRunner extends Sprite
	{
		public function HashMapExamplesRunner()
		{
			const iterations:int = 10000;//The number over the loop will iterate the test method.
			const runs:int = 100;//How many time the test is run.
			const delay:int = 50;//How long the delay is between to run.
			
			BaseHashMapExample.setReadArrayLength(10000);//The size of the array for the reading tests.
			
			var suite:BenchmarkSuite = new BenchmarkSuite();
			suite.addBenchmark(new ArrayHashMap, iterations, runs, delay);
			suite.addBenchmark(new DictionaryHashMap, iterations, runs, delay);
			suite.addBenchmark(new ArrayWithArrayHashMap, iterations, runs, delay);
			suite.addBenchmark(new ArrayWithObjectHashMap, iterations, runs, delay);
			suite.addBenchmark(new ArrayWithVOHashMap, iterations, runs, delay);
			
			var printer:ResultPrinter = new ResultPrinter(suite);			
			suite.run();
		}

	}
}