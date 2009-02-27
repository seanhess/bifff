package tests.matcher
{
	import magic.Matcher;
	import magic.Node;
	
	import mx.controls.Button;
	
	import net.digitalprimates.fluint.tests.TestCase;
	
	import tests.SampleViews;
	
	public class TestMultipleMatching extends TestCase
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
		public function nestedLabel():void
		{
			assertEquals(true, matcher.begin(views.oneButton, [views.vbox, views.one ]));
			assertEquals(true, matcher.begin(views.nestedLabel, [views.canvas, views.box, views.label]));
			assertEquals(true, matcher.begin(views.nestedLabel, [views.one, views.myStyle, views.label ]));
			assertEquals(true, matcher.begin(views.nestedLabel, [views.one, views.any]));
		}
		
		[Test]
		public function buttonBox():void
		{
			assertEquals(false, matcher.begin(views.mainHBox, [views.main, views.any]));
			assertEquals(true, matcher.begin(views.henry1, [views.main, views.any]));
			assertEquals(true, matcher.begin(views.henry2, [views.main, views.any]));
			assertEquals(true, matcher.begin(views.henry3, [views.main, views.any]));
			assertEquals(true, matcher.begin(views.henry4, [views.main, views.any]));
			assertEquals(true, matcher.begin(views.henry5, [views.main, views.any]));
			assertEquals(true, matcher.begin(views.mainVBox, [views.main, views.any]));
		}
		

	}
}