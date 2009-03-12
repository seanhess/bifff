package tests.smartobjects
{
	import net.digitalprimates.fluint.tests.TestCase;
	import net.seanhess.bifff.core.Resolver;
	import net.seanhess.bifff.core.Scope;
	import net.seanhess.bifff.core.SmartObject;
	import net.seanhess.bifff.utils.SmartEvent;
	import net.seanhess.bifff.utils.SmartTarget;
	
	public class TestNested extends TestCase
	{
		protected var event:SmartEvent;
		protected var target:SmartTarget;
		protected var resolver:Resolver;
		
		override protected function setUp():void
		{
			event = new SmartEvent();
			target = new SmartTarget();
			resolver = new Resolver();
		}
		
		[Test]
		public function nestSingle():void
		{
			var value:SmartObject = event.target;
			assertEquals("target", value.soProperty);
		}
		
		[Test]
		public function nestDouble():void
		{
			var value:SmartObject = event.target.data;
			assertEquals("data", value.soProperty);
		}
		
		[Test]
		public function nestTriple():void
		{
			var value:SmartObject = event.target.data.source;
			assertEquals("source", value.soProperty);
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
			
			assertEquals("data", value.soProperty);
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
			
			assertEquals("data", value.soSource.soProperty);
			assertEquals("source", value.soProperty);
			assertEquals("hello", resolver.resolveObject(value, new Scope({target:myTarget})));			
		}
	}
}