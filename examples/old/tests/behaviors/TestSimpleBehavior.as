package tests.behaviors
{
	import flash.display.DisplayObjectContainer;
	
	import mx.core.Application;
	
	import net.digitalprimates.fluint.tests.TestCase;
	import net.seanhess.bifff.behaviors.Behavior;
	import net.seanhess.bifff.scope.Scope;
	
	public class TestSimpleBehavior extends TestCase
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
		public function simpleBehavior():void
		{
			container.addChild(view);
			assertEquals(50, view.button.width);
			
			var behavior:Behavior = new Behavior();
				behavior.generator = SimpleBehavior;
				behavior.target = view.button;
				
			assertEquals(300, view.button.width);
		}
	}
}