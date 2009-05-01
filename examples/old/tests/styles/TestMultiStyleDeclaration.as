package tests.styles
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.core.Application;
	import mx.events.FlexEvent;
	
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
			assertTrue("has one", multi.toString().match("one"));
			assertTrue("has two", multi.toString().match("two"));
			assertTrue("has three", multi.toString().match("three"));
			
			multi.addStyle("four");
			assertTrue("has four", multi.toString().match("four"));
			assertTrue("has one", multi.toString().match("one"));
			assertTrue("has two", multi.toString().match("two"));
			assertTrue("has three", multi.toString().match("three"));
			
			multi.removeStyle("two");
			assertTrue("has one", multi.toString().match("one"));
			assertTrue("has three", multi.toString().match("three"));
			assertTrue("has four", multi.toString().match("four"));
			assertFalse("has two", multi.toString().match("two"));
		}
		
		[Test]
		public function testAutomaticStyles():void
		{
			container.addChild(view);
			view.addEventListener(FlexEvent.CREATION_COMPLETE, asyncHandler(onComplete,1000));
		}
		
		protected function onComplete(event:Event, blah:*):void
		{
//			assertTrue("Is Multi? " , view.button.styleName is MultiStyleDeclaration);
		}
	}
}