package suite
{
	import com.zanshine.benchmark.lang.EnumTest;
    import net.digitalprimates.fluint.tests.TestSuite;

    import com.zanshine.benchmark.core.BenchmarkSuiteTest;
    import com.zanshine.benchmark.core.BenchmarkCaseTest;
    import com.zanshine.benchmark.runner.MethodCallBackTest;
    import com.zanshine.benchmark.runner.CaseDescriptorTest;
    import com.zanshine.benchmark.print.TracePrinterTargetTest;
    import com.zanshine.benchmark.print.ResultPrinterTest;
    import com.zanshine.benchmark.runner.TestRunnerTest;
    import com.zanshine.benchmark.runner.CaseRunnerTest;
    import com.zanshine.benchmark.utils.GlobalFunctionEnsureTest;
    import com.zanshine.benchmark.utils.GlobalFunctionRequireTest;

    public class Runner extends TestSuite
	{
		public function Runner()
		{
			
			utils();
			core();
		}
		
		private function core():void
		{
			addTestCase(new EnumTest());
			addTestCase(new MethodCallBackTest)
			addTestCase(new CaseDescriptorTest);
			addTestCase(new BenchmarkCaseTest);
			addTestCase(new TracePrinterTargetTest);
			addTestCase(new ResultPrinterTest);
			addTestCase(new BenchmarkSuiteTest);
			addTestCase(new CaseRunnerTest);
			addTestCase(new TestRunnerTest);
		}
		
		private function utils():void
		{
			addTestCase(new GlobalFunctionRequireTest);
			addTestCase(new GlobalFunctionEnsureTest);
		}
	}
}