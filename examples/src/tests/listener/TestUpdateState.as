package tests.listener
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.core.Application;
	
	import net.digitalprimates.fluint.tests.TestCase;
	import net.seanhess.bifff.behaviors.Listener;
	import net.seanhess.bifff.core.Apply;
	
	public class TestUpdateState extends TestCase
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
		public function updateState():void
		{
			container.addChild(view);
			
			assertEquals("Nothing", view.string);
			view.apply.addEventListener(Apply.INITIALIZED, asyncHandler(onInit, 1000));
		}
		
		protected function onInit(event:Event, blah:*):void
		{
			view.stateOne.addEventListener(Listener.HANDLE, asyncHandler(onHandleOne, 1000));
			view.currentState = "one";
		}			
		
		protected function onHandleOne(event:Event, blah:*):void
		{	
			assertEquals("one", view.string);
			view.stateTwo.addEventListener(Listener.HANDLE, asyncHandler(onHandleTwo, 1000));
			view.currentState = "two"
		}
		
		protected function onHandleTwo(event:Event, blah:*):void
		{
			assertEquals("two", view.string);
		}
	}
}