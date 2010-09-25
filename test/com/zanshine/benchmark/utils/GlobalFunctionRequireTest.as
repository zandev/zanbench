package com.zanshine.benchmark.utils
{
	import com.zanshine.benchmark.error.RequirementViolationError;
	
	import com.zanshine.benchmark.utils.require;
	
	public class GlobalFunctionRequireTest extends GlobalFunctionsContractsTest
	{
		public function GlobalFunctionRequireTest()
		{
			super();
			contractFunction = require;
			expectedErrorClass = RequirementViolationError;
		}
		
	}
}