package tests.matcher
{
	import magic.Matcher;
	import magic.Node;
	
	import mx.controls.Button;
	
	import net.digitalprimates.fluint.tests.TestCase;
	
	import tests.SampleViews;
	
	public class TestRecursiveMatching extends TestCase
	{
		protected var matcher:Matcher;
		protected var views:SampleViews;
		
		override protected function setUp():void
		{
			matcher = new Matcher();
			views = new SampleViews();
		}
		
		override protected function tearDown():void
		{
			matcher = null;
			views = null;
		}
		
		[Test]
		public function matchImmediately():void
		{
			assertEquals(true, matcher.matchRecursive(views.oneButton, [views.one]));
			assertEquals(true, matcher.matchRecursive(views.oneButton, [views.myStyle]));
			assertEquals(false, matcher.matchRecursive(views.threeButton, [views.myStyle]));
		}
		
		[Test]
		public function matchParentBox():void
		{
			assertEquals(true, matcher.matchRecursive(views.oneButton, [views.button]));
			assertEquals(false, matcher.matchRecursive(views.threeButton, [views.myStyle]));
		}
		
		[Test]
		public function matchMultipleNesting():void
		{
			assertEquals(true, matcher.matchRecursive(views.nestedLabel, [views.one]));
			assertEquals(true, matcher.matchRecursive(views.nestedLabel, [views.myStyle]));
			assertEquals(true, matcher.matchRecursive(views.nestedLabel, [views.canvas]));
		}
		
		

	}
}