package tests.listener
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.core.Application;
	
	import net.digitalprimates.fluint.tests.TestCase;
	import net.seanhess.bif.behaviors.Bind;
	
	public class TestBinding extends TestCase
	{
		protected var view:ViewWithStates;
		protected var container:DisplayObjectContainer;
		
		override protected function setUp():void
		{
			view = new ViewWithStates();
			container = Application.application as DisplayObjectContainer;
		}
		
		override protected function tearDown():void
		{
			if (container.contains(view))
				container.removeChild(view);
				
			view = null;
			container = null;
		}

		[Test]
		public function updateBinding():void
		{
			container.addChild(view);
			
			assertEquals("Nothing", view.string);
			view.binding.addEventListener(Bind.UPDATE, asyncHandler(onUpdate, 1000));
			view.string = "fat";
		}			
		
		protected function onUpdate(event:Event, blah:*):void
		{	
			assertEquals("fat", view.string);
			assertEquals("charlie", view.secondString);
		}
	}
}