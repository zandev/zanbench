package com.zanshine.benchmark.utils
{
	import net.digitalprimates.fluint.tests.TestCase;

	public class GlobalFunctionsContractsTest extends TestCase
	{
		protected var contractFunction:Function;
		protected var expectedErrorClass:Class;

		public function GlobalFunctionsContractsTest()
		{
			super();
		}

		public function test_violation_should_trow_an_error():void
		{
			try
			{
				contractFunction("message", false);
			}
			catch (e:*)
			{
				if (e is expectedErrorClass)
					return ;
			}
			fail("Should throw an error");
		}

		public function test_acceptance_should_not_trow_an_error():void
		{
			try
			{
				contractFunction("message", true);
			}
			catch (e:*)
			{
				if (e is expectedErrorClass)
					fail("Should not throw an error");
			}
		}
/* 
		public function test_violation_with_several_arguments():void
		{
			try
			{
				contractFunction(true, 1 == 1, {}is Object, false);
			}
			catch (e:*)
			{
				if (e is expectedErrorClass)
					return ;
			}
			fail("Should throw an error");
		}

		public function test_acceptance_with_several_arguments():void
		{
			try
			{
				contractFunction(true, 1 == 1, {}is Object, true);
			}
			catch (e:*)
			{
				if (e is expectedErrorClass)
					fail("Should not throw an error");
			}
		}
 */
		public function test_requirements_could_be_expressed_as_functions():void
		{
			var error:Error;

			//true expectation
			try
			{
				contractFunction("message", function():*
					{
						return true;
					});
			}
			catch (e:*)
			{
				if (e is expectedErrorClass)
					fail("Should not throw an error");
			}

			//false expectation
			try
			{
				contractFunction("message", function():*
					{
						return false;
					});
			}
			catch (e:*)
			{
				if (e is expectedErrorClass)
					return ;
			}

			fail("Should throw an error");
		}

		public function test_requirements_object_should_be_boolean():void
		{
			try
			{
				contractFunction("message", {});
			}
			catch (e:*)
			{
				if (e is expectedErrorClass)
					return ;
			}
			fail("Should throw an error");
		}
		
		public function test_requirements_function_should_return_boolean():void
		{
			try
			{
				contractFunction("message", function():* {return {} } );
			}
			catch (e:*)
			{
				if (e is expectedErrorClass)
					return ;
			}
			fail("Should throw an error");
		}
	}
}