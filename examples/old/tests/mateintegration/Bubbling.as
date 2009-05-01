package tests.mateintegration
{
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import net.digitalprimates.fluint.tests.TestCase;
	
	public class Bubbling extends TestCase
	{
		[Test]
		public function checkBubbling():void
		{
			var something:UIComponent = new UIComponent();
				something.addEventListener("test", onSecondaryTest);
				something.addEventListener("creationComplete", onSecondaryCreationComplete);
			
			var dispatcher:FakeDispatcher = new FakeDispatcher();
				dispatcher.addEventListener("test", onDirectTest);
				dispatcher.addEventListener("creationComplete", onDirectCreationComplete);
				dispatcher.go();
			
			assertTrue("bob", true);
		}
		
		protected function onDirectTest(event:Event):void
		{
			var bob:Boolean = true;
		}
		
		protected function onSecondaryTest(event:Event):void
		{
			var bob:Boolean = true;
		}
		
		protected function onDirectCreationComplete(event:Event):void
		{
					var henry:Boolean = true;
			
		}
		
		protected function onSecondaryCreationComplete(event:Event):void
		{
			var henry:Boolean = true;
		}
	}
}