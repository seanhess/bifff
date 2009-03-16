package tests.styles
{
	import flash.display.DisplayObjectContainer;
	
	import mx.core.Application;
	
	import net.digitalprimates.fluint.tests.TestCase;
	import net.seanhess.bifff.core.MultiStyleDeclaration;
	
	public class TestMultiStyleDeclaration extends TestCase
	{
		protected var view:View;
		protected var container:DisplayObjectContainer;
		protected var multi:MultiStyleDeclaration;
		
		override protected function setUp():void
		{
			view = new View();
			container = Application.application as DisplayObjectContainer;
			multi = new MultiStyleDeclaration();
		}
		
		override protected function tearDown():void
		{
			if (container.contains(view))
				container.removeChild(view);
				
			view = null;
			container = null;
			multi = null;
		}
		
		[Test]
		public function addRemoveSetString():void
		{
			multi.styleNames = "one two three";
			assertEquals("one two three", multi.toString());
			
			multi.addStyle("four");
			assertTrue("has four", multi.toString().match("four"));
			assertTrue("has one two three", multi.toString().match("one two three"));
			
			multi.removeStyle("two");
			assertTrue("has one", multi.toString().match("one"));
			assertTrue("has three", multi.toString().match("three"));
			assertTrue("has four", multi.toString().match("four"));
			assertFalse("has two", multi.toString().match("two"));
		}
		
		[Test]
		public function testAutomaticStyles():void
		{
						
			
		}
	}
}