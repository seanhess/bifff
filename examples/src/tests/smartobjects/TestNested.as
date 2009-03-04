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
		
//		[Test]
//		public function nestDoubleWithCheck():void
//		{
//			var value:SmartObject = smart.event.target.data;
//			
//			var event:Object = {
//				target: {
//					data: "hello"					
//				}
//			}
//			
//			assertEquals("data", value.property);
//			assertEquals("hello", resolver.resolveObject(value, new Scope(null, null, event)));
//		}
//		
//		[Test]
//		public function nestObjects():void
//		{
//			var value:SmartObject = smart.event.target.data.source;
//			
//			var event:Object = {
//				target: {
//					data: {
//						source: "hello"
//					}
//				}
//			}
//			
//			assertEquals("data", value.source.property);
//			assertEquals("source", value.property);
//			assertEquals("hello", resolver.resolveObject(value, new Scope(null, null, event)));			
//		}
	}
}