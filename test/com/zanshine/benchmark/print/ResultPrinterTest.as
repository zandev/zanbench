package com.zanshine.benchmark.print
{
	import com.zanshine.benchmark.kind.PrinterEventKind;
	import com.zanshine.benchmark.print.TracePrinterTarget;
	
	import com.zanshine.benchmark.core.BenchmarkSuite;
	
	
	import com.zanshine.benchmark.event.PrinterEvent;
	
	import flash.utils.getQualifiedClassName;
	
	import net.digitalprimates.fluint.tests.TestCase;
	
	import mock.MethodsNamesCaseMock;

	public class ResultPrinterTest extends TestCase
	{
		public function testDispatchResultPrintedEvent():void
		{			
			var suite:BenchmarkSuite = new BenchmarkSuite();
			suite.addBenchmark(new MethodsNamesCaseMock);
			
			var printer:ResultPrinter = new ResultPrinter(suite);
			printer.addEventListener(PrinterEventKind.RESULT_PRINTED.uid, asyncHandler(new Function, 50));
			
			suite.run();
		}
		 
		public function testDefaultPrinterTarget():void
		{
			var message:String = "Expected default print target to be of type " + 
								 getQualifiedClassName(new TracePrinterTarget);
								 
			var printer:ResultPrinter = new ResultPrinter(new BenchmarkSuite);
			assertTrue(message, printer.printerTarget is TracePrinterTarget);
		}
	}
}