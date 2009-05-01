package tests.smartobjects
{
	import net.digitalprimates.fluint.tests.TestCase;
	import net.seanhess.bifff.core.Resolver;
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.scope.SmartObject;
	
	public class TestNested extends TestCase
	{
		protected var event:SmartObject;
		protected var target:SmartObject;
		protected var resolver:Resolver;
		
		override protected function setUp():void
		{
			event = new SmartObject("event");
			target = new SmartObject("currentTarget");
			resolver = new Resolver();
		}
		
		[Test]
		public function nestSingle():void
		{
			var value:SmartObject = event.target;
			assertEquals("target event", value.toString());
		}
		
		[Test]
		public function nestDouble():void
		{
			var value:SmartObject = event.target.data;
			assertEquals("data target event", value.toString());
		}
		
		[Test]
		public function nestTriple():void
		{
			var value:SmartObject = event.target.data.source;
			assertEquals("source data target event", value.toString());
		}
		
		[Test]
		public function nestDoubleWithCheck():void
		{
			var value:SmartObject = target.bob.data;
			
			var myTarget:Object = {
				bob: {
					data: "hello"					
				}
			}
			
			assertEquals("data bob currentTarget", value.toString());
			assertEquals("hello", resolver.resolveObject(value, new Scope({target:myTarget})));
		}
		
		[Test]
		public function nestObjects():void
		{
			var value:SmartObject = target.bob.data.source;
			
			var myTarget:Object = {
				bob: {
					data: {
						source: "hello"
					}
				}
			}
			
			assertEquals("source data bob currentTarget", value.toString());
			assertEquals("hello", resolver.resolveObject(value, new Scope({target:myTarget})));			
		}
	}
}