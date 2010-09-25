package mock 
{
    import com.zanshine.benchmark.lang.AbstractEnum;

    public class SecondMockEnum extends AbstractEnum 
    {
    	public static const FIRST :SecondMockEnum = new SecondMockEnum("");
    	public static const SECOND:SecondMockEnum = new SecondMockEnum("");
    	public static const THIRD :SecondMockEnum = new SecondMockEnum("");
    	
        public function SecondMockEnum(name:String)
        {
            super(contructorKey, name);
        }
    }
}
