package mock
{
	import com.zanshine.benchmark.core.BenchmarkCase;
	
	public class MethodsNamesCaseMock extends BenchmarkCase
	{
		public static const METHODS_COUNT:int = 3;
		
		public var runnedMethods:Array = [];
		
		[Benchmark("a message")]
		public function aMetaTaggedMethod():void
		{
			runnedMethods.push("aMetaTaggedMethod");
		}
		
		[Benchmark("another message")]
		public function anOtherMetaTaggedMethod():void
		{
			runnedMethods.push("anOtherMetaTaggedMethod");
		}
		
		[Benchmark("yet an other message")]
		public function yetAnOtherMetaTaggedMethod():void
		{
			runnedMethods.push("yetAnOtherMetaTaggedMethod");
		}
	}
}