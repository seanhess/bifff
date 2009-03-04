package tests.realmatching
{
	import flash.display.DisplayObjectContainer;
	
	import mx.core.Application;
	
	import net.digitalprimates.fluint.tests.TestCase;
	import net.seanhess.bif.core.BifffEvent;
	
	public class TestMatchInstance extends TestCase
	{
		protected var data:RealMatching;
		protected var container:DisplayObjectContainer;
		
		override protected function setUp():void
		{
			data = new RealMatching();
			container = Application.application as DisplayObjectContainer;
		}
		
		override protected function tearDown():void
		{
			if (container.contains(data.container))
				container.removeChild(data.container);
			
			data = null;
		}
		
		[Test]
		public function matchDirect():void
		{
			data.directMatchMap.addEventListener(BifffEvent.FOUND_MATCH, asyncHandler(onAdded,2000));
			container.addChild(data.container);	
		}
		
		protected function onAdded(event:BifffEvent, stuff:Object=null):void
		{
			assertEquals(data.stack, event.matchedTarget);
		}

	}
}