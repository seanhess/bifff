package tests.selfselection
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.core.Application;
	import mx.events.FlexEvent;
	
	import net.digitalprimates.fluint.tests.TestCase;
	import net.seanhess.bif.core.BifffEvent;
	
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
			button.addEventListener("hello", asyncHandler(onHello, 1000));
			container.addChild(button);
		}
		
		protected function onHello(event:Event, pass:*):void
		{
			assertTrue("woot", true);
		}
	}
}