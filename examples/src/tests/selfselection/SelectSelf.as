package tests.selfselection
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.core.Application;
	
	import net.digitalprimates.fluint.tests.TestCase;
	import net.seanhess.bifff.core.Apply;
	
	public class SelectSelf extends TestCase
	{
		protected var button:SampleButton;
		protected var container:DisplayObjectContainer;
		
		override protected function setUp():void
		{
			button = new SampleButton();
			container = Application.application as DisplayObjectContainer;
		}
		
		override protected function tearDown():void
		{
			if (container.contains(button))
				container.removeChild(button);
				
			container = null;
			button = null;
		} 
		
		[Test]
		public function buttonSelfSelect():void
		{
 			container.addChild(button);
			button.apply.addEventListener(Apply.INITIALIZED, asyncHandler(onInit, 1000));
		}
		
		protected function onInit(event:Event, pass:*):void
		{
			button.addEventListener("hello", asyncHandler(onHello, 1000));
			button.dispatchEvent(new Event("test"));
		}
		
		protected function onHello(event:Event, pass:*):void
		{
			assertTrue("woot", true);
		}
	}
}