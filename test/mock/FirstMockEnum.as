package mock 
{
    import com.zanshine.benchmark.lang.AbstractEnum;

    public class FirstMockEnum extends AbstractEnum 
    {
    	public static const FIRST:FirstMockEnum = new FirstMockEnum("enumName");
        public static const SECOND:FirstMockEnum = new FirstMockEnum("enumName");
        
        public function FirstMockEnum(name:String)
        {
            super(contructorKey, name);
        }
    }
}
