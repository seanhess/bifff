package tests.setandget
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.core.Application;
	
	import net.digitalprimates.fluint.tests.TestCase;
	import net.seanhess.bifff.actions.Listener;
	import net.seanhess.bifff.core.BifffEvent;
	
	public class TestSet extends TestCase
	{
		protected var view:View;
		protected var container:DisplayObjectContainer;
		
		override protected function setUp():void
		{
			view = new View();
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
		public function directSet():void
		{
			container.addChild(view);
			view.map.addEventListener(BifffEvent.FOUND_MATCH, asyncHandler(onFoundMatch,1000));
		}
		
		protected function onFoundMatch(event:BifffEvent, blah:*):void
		{
			assertEquals(view.button, event.matchedTarget);
			assertEquals(view.selector, event.selector);

			view.listener.addEventListener(Listener.HANDLE, asyncHandler(onHandle, 1000));
			view.button.dispatchEvent(new Event("test"));
		}
		
		protected function onHandle(event:Event, blah:*):void
		{
			assertEquals("w00t", view.string);
			assertEquals("w00t", view.button.label);
		}
		
		[Test]
		public function resolveSet():void
		{
			container.addChild(view);
			view.resolveMap.addEventListener(BifffEvent.FOUND_MATCH, asyncHandler(onFoundMatchResolve,1000));
		}
		
		protected function onFoundMatchResolve(event:BifffEvent, blah:*):void
		{
			assertEquals(view.w00t, event.matchedTarget);
			assertEquals(view.resolve, event.selector);

			view.resolveListener.addEventListener(Listener.HANDLE, asyncHandler(onHandleResolve, 1000));
			view.w00t.dispatchEvent(new Event("test"));
		}
		
		protected function onHandleResolve(event:Event, blah:*):void
		{
			assertEquals("Hello", view.string);
		}
	}
}