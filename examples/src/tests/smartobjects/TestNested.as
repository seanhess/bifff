package tests.smartobjects
{
	import net.digitalprimates.fluint.tests.TestCase;
	import net.seanhess.bif.core.Resolver;
	import net.seanhess.bif.core.Scope;
	import net.seanhess.bif.core.SmartObject;
	import net.seanhess.bif.utils.SmartObjects;
	
	public class TestNested extends TestCase
	{
		protected var smart:SmartObjects;
		protected var resolver:Resolver;
		
		override protected function setUp():void
		{
			smart = new SmartObjects();
			resolver = new Resolver();
		}
		
		[Test]
		public function nestSingle():void
		{
			var value:SmartObject = smart.event.target;
			assertEquals("target", value.soProperty);
		}
		
		[Test]
		public function nestDouble():void
		{
			var value:SmartObject = smart.event.target.data;
			assertEquals("data", value.soProperty);
		}
		
		[Test]
		public function nestTriple():void
		{
			var value:SmartObject = smart.event.target.data.source;
			assertEquals("source", value.soProperty);
		}
		
		[Test]
		public function nestDoubleWithCheck():void
		{
			var value:SmartObject = smart.target.bob.data;
			
			var target:Object = {
				bob: {
					data: "hello"					
				}
			}
			
			assertEquals("data", value.soProperty);
			assertEquals("hello", resolver.resolveObject(value, new Scope({target:target})));
		}
		
		[Test]
		public function nestObjects():void
		{
			var value:SmartObject = smart.target.bob.data.source;
			
			var target:Object = {
				bob: {
					data: {
						source: "hello"
					}
				}
			}
			
			assertEquals("data", value.soSource.soProperty);
			assertEquals("source", value.soProperty);
			assertEquals("hello", resolver.resolveObject(value, new Scope({target:target})));			
		}
	}
}