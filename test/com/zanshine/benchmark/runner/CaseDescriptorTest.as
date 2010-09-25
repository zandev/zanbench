package com.zanshine.benchmark.runner
{
	
	
	
	
	import mock.SimpleCaseMock;
	import mock.WellOrderedMock;
	import mock.ChaoticOrderedMock;
	import mock.BadOrderedMock;
	
	
	
	import flash.utils.getQualifiedClassName;
	
	import net.digitalprimates.fluint.tests.TestCase;

	public class CaseDescriptorTest extends TestCase
	{
		private var cDescriptor:BenchmarkCaseDescriptor;
		
		override protected function setUp():void
		{
			cDescriptor = new BenchmarkCaseDescriptor(new Mock);
		}
		
		public function testClassName():void
		{
			assertEquals(getQualifiedClassName(new Mock), cDescriptor.className);
		}
		
		public function testMethodsCount():void
		{
			assertTrue(cDescriptor.tests.length == 3);
		}
		
		public function testMethodsNames():void
		{
			var flag:Boolean;
			for each(var name:String in Mock.BENCH_METHODS_NAMES)
			{
				flag = false;
				for each(var meth:TestMethodDescriptor in cDescriptor.tests)
				{
					if(meth.name == name)
					{
						flag = true;
						break;
					}
				}
				assertTrue(flag);
			}
		}
		
		private var messageMock:SimpleCaseMock;
		public function testMessageAssignation():void
        {
            messageMock = new SimpleCaseMock();
            cDescriptor = new BenchmarkCaseDescriptor(messageMock);
            assertEquals(SimpleCaseMock.MESSAGE, TestMethodDescriptor(cDescriptor.tests[0]).message);
        }

        public function testOrderAssignation():void
		{
			messageMock = new SimpleCaseMock();
            cDescriptor = new BenchmarkCaseDescriptor(messageMock);
            assertEquals(SimpleCaseMock.ORDER, TestMethodDescriptor(cDescriptor.tests[0]).order);
		}
		
		private var wellOrderedMock: WellOrderedMock;
		public function testOrderWithAllMethodsAnotated():void
        {
            wellOrderedMock = new WellOrderedMock();
            cDescriptor = new BenchmarkCaseDescriptor(wellOrderedMock);
            
            var i:int = 0;
            for each (var s:String in WellOrderedMock.EXPECTED_ORDER)
            {
            	assertEquals(s, TestMethodDescriptor(cDescriptor.tests[i]).name);
            	i++;
            }
		}
		
		private var badOrderedMock: BadOrderedMock;
		public function testOrderWithOneMethodAnotated():void
        {
            badOrderedMock = new BadOrderedMock();
            cDescriptor = new BenchmarkCaseDescriptor(badOrderedMock);
            
            var i:int = 0;
            for each (var s:String in BadOrderedMock.EXPECTED_ORDER)
            {
            	assertEquals(s, TestMethodDescriptor(cDescriptor.tests[i]).name);
            	i++;
            }
		}
		
		private var chaoticOrderedMock: ChaoticOrderedMock;
		public function testChaoticOrderWith():void
        {
            chaoticOrderedMock = new ChaoticOrderedMock();
            cDescriptor = new BenchmarkCaseDescriptor(chaoticOrderedMock);
            
            var i:int = 0;
            for each (var s:String in ChaoticOrderedMock.EXPECTED_ORDER)
            {
            	assertEquals(s, TestMethodDescriptor(cDescriptor.tests[i]).name);
            	i++;
            }
		}
	}
}

import com.zanshine.benchmark.core.BenchmarkCase;	

class Mock extends BenchmarkCase
{
	public static const BENCH_METHODS_NAMES:Array = 
	[
		"firstBenchmarkableMethod",
		"secondBenchmarkableMethod",
		"lastBenchmarkableMethod"
	];
	
	public function simpleMethod(arg:int):void
	{
		
	}
	
	[Benchmark(message="value with key")]
	public function firstBenchmarkableMethod():void
	{
		
	}
	
	[Benchmark("value only")]
	public function secondBenchmarkableMethod():void
	{
		
	}
	
	[Benchmark]
	public function lastBenchmarkableMethod():void
	{
		
	}
	
}