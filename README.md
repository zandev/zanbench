zanbench is a lightweight xUnit-like actionscript 3 framework for performances testing. It allow you to write benchmarks in a xUnit like manner :

* Create a BenchmarkCase by inheriting from BenchmarkCase or implementing Benchmarkable
* Write tests methods (basicaly, something you want to loop over)
* Tag these tests methods with the "Benchmark" metadata tag
* If needed, define callback's actions in four methods :
  1. prepare() : called before any test method
  2. setUp() : called before each test method
  3. tearDown() : called after each test method
  4. clean() : called after all test methods 
* add your BenchmarkCase to a suite
* run the suite 

zanbench let you split the tests methods iterations in runs, and define delay between these runs. This allow you to have more control over the system resources usage for very loud benchmarks.

zanbench is in it's very first release, more features will come over time. 

Usage: (from ./example/simple/*)

        package simple 
        {
            import com.zanshine.benchmark.core.BenchmarkCase;

            public class SimpleBenchmarkCase extends BenchmarkCase 
            {
              /**
               * before callbacks
               */
              override public function prepare():void
              {
                    comment("The prepare() method is called before any test run", "prepare");
              }

              override public function setUp():void
              {
                    comment("Before each test, the setUp() method is called", "setUp");
              }

              /**
               * First test method
               */

              public function beforeFirstTestSimpleMethod():void
              {
                comment("You can define a before callback for any given method " +
                "by simply use a \"before\" prefix with the method name camelized", "beforeFirstTestSimpleMethod"); 
              }

              [Benchmark(order=2, message="This is a first simple test method")]
              public function firstTestSimpleMethod():void
              {
                comment("This is the first test method (in order of class declaration). " +
                "It is called after the second test method, because we've assigned it " +
                "an order=2 in the Benchmark metadata tag. " +
                "This method is where you put the code you want to benchmark. " +
                "Accordingly to the arguments given to the addBenchmark method in the suite, " +
                "this method will be called 4 times.", "firstTestSimpleMethod");
              }

              public function afterFirstTestSimpleMethod():void
              {
                comment("You can define a before callback for any given method " +
                "by simply use an \"after\" prefix with the method name camelized", "afterFirstTestSimpleMethod");
              }

              /**
               * Second test method
               */
              public function beforeSecondTestSimpleMethod():void
              {
                comment("You can define a before callback for any given method " +
                "by simply use a \"before\" prefix with the method name camelized", "beforeSecondTestSimpleMethod");
              }

              [Benchmark(order=1, message="This is a first simple test method")]
              public function secondTestSimpleMethod():void
              {
                comment("This is the second test method (in order of class declaration). " +
                "It is called after the second test method, because we've assigned it " +
                "an order=2 in the Benchmark metadata tag. " +
                "This method is where you put the code you want to benchmark. " +
                "Accordingly to the arguments given to the addBenchmark method in the suite, " +
                "this method will be called 4 times.", "secondTestSimpleMethod");
              }

              public function afterSecondTestSimpleMethod():void
              {
                comment("You can define a before callback for any given method " +
                "by simply use an \"after\" prefix with the method name camelized", "afterSecondTestSimpleMethod");
              }

              /**
               * After callbacks
               */

              override public function tearDown():void
              {
                comment("After each test, the tearDown() method is called", "tearDown");
              }

              override public function clean():void
              {
                comment("The clean() method is called after all tests runs", "clean");
              }

              /**
               * Here is an helper method :
               */

              private function comment(string:String, method:String):void
              {
                    trace("\n");
                    trace("- ##### => " + method + "() called");
                    trace("- " + string);
                    trace("--------------------------------------------------------");
              }
          }
        }

And now run the tests:  

        package  
        {
            import com.zanshine.benchmark.print.ResultPrinter;
            import simple.SimpleBenchmarkCase;
            import com.zanshine.benchmark.core.BenchmarkSuite;

            import flash.display.Sprite;

            public class SimpleExampleRunner extends Sprite 
            {
                public function SimpleExampleRunner()
                {

                    var suite:BenchmarkSuite = new BenchmarkSuite();
                    suite.addBenchmark(new SimpleBenchmarkCase(), 2, 2, 500);

                    var printer:ResultPrinter = new ResultPrinter(suite);
                    suite.run(); 
                }
            }
        }

For more examples, see the example directory
