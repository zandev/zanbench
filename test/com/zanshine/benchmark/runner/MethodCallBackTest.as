package com.zanshine.benchmark.runner 
{
    import net.digitalprimates.fluint.tests.TestCase;

    import com.zanshine.benchmark.runner.AfterCallBack;
    import com.zanshine.benchmark.runner.BeforeCallBack;
    
    import com.zanshine.benchmark.runner.MethodCallBack;

    public class MethodCallBackTest extends TestCase 
    {
    	public function testBeforeCallBack():void
    	{
    		var mock:MockWithCallBacks = new MockWithCallBacks();
    		var callBack:CallBack = new MethodCallBack(mock, "aMethod", MethodCallBack.BEFORE);
    		callBack.execute();
    		
    		assertTrue(mock.beforeAMethodCalled);
        }
        
        public function testAfterCallBack():void
    	{
    		var mock:MockWithCallBacks = new MockWithCallBacks();
    		var callBack:CallBack = new MethodCallBack(mock, "aMethod", MethodCallBack.AFTER);
            callBack.execute();
    		
    		assertTrue(mock.afterAMethodCalled);
        }
        
        public function testBeforeCallBackSubClass():void
    	{
    		var mock:MockWithCallBacks = new MockWithCallBacks();
    		var callBack:CallBack = new BeforeCallBack(mock, "aMethod");
    		callBack.execute();
    		
    		assertTrue(mock.beforeAMethodCalled);
        }
        
        public function testAfterCallBackSubClass():void
    	{
    		var mock:MockWithCallBacks = new MockWithCallBacks();
    		var callBack:CallBack = new AfterCallBack(mock, "aMethod");
    		callBack.execute();
    		
    		assertTrue(mock.afterAMethodCalled);
        }
        
        public function testShouldNotThrowAnErrorIfCallBackFail():void
        {
        	var mock:MockWithoutCallBack = new MockWithoutCallBack();
    		var callBack:CallBack = new MethodCallBack(mock, "aMethod", MethodCallBack.BEFORE);
            try
            {
            	callBack.execute();
            }
    		catch(e:Error)
    		{
    			fail("should not throw an error when the call back method does not exist");
    		}
        }
        
    }
}

class MockWithCallBacks
{
	public var beforeAMethodCalled:Boolean;
	
	public function beforeAMethod():void
    {
        beforeAMethodCalled = true;
    }
	
	public var afterAMethodCalled:Boolean;
	
	public function afterAMethod():void
    {
        afterAMethodCalled = true;
    }
}

class MockWithoutCallBack
{
	public function aMethod():void
	{
		
	}
}