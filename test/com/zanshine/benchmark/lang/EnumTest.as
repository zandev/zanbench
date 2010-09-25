package com.zanshine.benchmark.lang 
{
	import mock.SecondMockEnum;
    import mock.FirstMockEnum;

    import net.digitalprimates.fluint.tests.TestCase;

    public class EnumTest extends TestCase 
    {
    	public function testName():void
    	{
    		var enum:Enum = FirstMockEnum.FIRST;
            assertEquals("enumName", enum.name);
        }
        
        public function testIdentifier():void
    	{
    		var enumA:Enum = FirstMockEnum.FIRST;
            var enumB:Enum = FirstMockEnum.SECOND;
            assertEquals(enumA.name, enumB.name);
            assertFalse(enumA.uid == enumB.uid);
        }
        
        public function testEnumExistHasClassesConstansOnly():void
        {
        	try
        	{
        		var enum:Enum = new FirstMockEnum("");
        	}
        	catch(e:Error)
        	{
        		return;
        	}
        	fail("Should throw an error when instatiating an Enum outside class constants");
        }
        
        public function testOrdering():void
        {
        	assertTrue(SecondMockEnum.FIRST < SecondMockEnum.SECOND);
        	assertTrue(SecondMockEnum.SECOND < SecondMockEnum.THIRD);
        }
    }
}