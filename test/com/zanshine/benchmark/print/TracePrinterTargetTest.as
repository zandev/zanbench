package com.zanshine.benchmark.print
{
	import com.zanshine.benchmark.print.TraceTargetPrinterTokens;
	import com.zanshine.benchmark.print.TracePrinterTarget;
	
	import com.zanshine.benchmark.core.TestResult;
    import net.digitalprimates.fluint.tests.TestCase;

    public class TracePrinterTargetTest extends TestCase
    {
    	private const CLASS_NAME:String = "SomeClassName",
    				  METHOD_NAME:String = "aMethodName",
    				  MESSAGE:String = " an very funny message",
    				  ITERATIONS:int = 13479,
    				  RUNS:int = 785,
    				  DELAY:int = 23;
    				  
        private var result:TestResult,
        			printerTarget:PrinterTarget,
        			resultArray:Array;
		
        override protected function setUp():void
        {
            result = new TestResult(CLASS_NAME, METHOD_NAME, MESSAGE, ITERATIONS, RUNS, DELAY);
            
            printerTarget = new TracePrinterTarget();
            printerTarget.print(result);
            resultArray = printerTarget.output.split("\n");
        }

        /**
		 * 
		 */
		
		public function testClassName():void
		{
			assertStringResult(resultArray[0], TraceTargetPrinterTokens.CLASS_NAME, CLASS_NAME);
        }
        
        public function testMethodName():void
		{
			assertStringResult(resultArray[1], TraceTargetPrinterTokens.METHOD, METHOD_NAME);
        }
        
        public function testMessage():void
		{
			assertStringResult(resultArray[2], TraceTargetPrinterTokens.MESSAGE, MESSAGE);
        }
        
        public function testIterationCount():void
		{
			assertStringResult(resultArray[3], TraceTargetPrinterTokens.ITERATIONS, ITERATIONS);
        }
        
        public function testRunCount():void
		{
			assertStringResult(resultArray[4], TraceTargetPrinterTokens.RUNS, RUNS);
        }
        
        public function testDelay():void
		{
			assertStringResult(resultArray[5], TraceTargetPrinterTokens.DELAY, DELAY);
        }
        
        /**
         * Helpers
         */
         
         private function assertStringResult(result:String, label:String, value:Object):void
         {
         	var expectedString:String = label + " => " + value.toString();
            assertEquals(expectedString, result);
        }
	}
}