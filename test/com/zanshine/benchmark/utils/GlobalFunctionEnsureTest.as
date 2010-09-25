package com.zanshine.benchmark.utils
{
	import com.zanshine.benchmark.error.EnsurementViolationError;
	
	import com.zanshine.benchmark.utils.ensure;
	
	
	public class GlobalFunctionEnsureTest extends GlobalFunctionsContractsTest
	{
		public function GlobalFunctionEnsureTest()
		{
			super();
			contractFunction = ensure;
			expectedErrorClass = EnsurementViolationError;
		}
		
	}
}