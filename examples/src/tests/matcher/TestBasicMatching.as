package tests.matcher
{
	import net.seanhess.bif.core.Matcher;
	import net.seanhess.bif.core.Node;
	
	import mx.controls.Button;
	
	import net.digitalprimates.fluint.tests.TestCase;
	
	import tests.SampleViews;
	
	public class TestBasicMatching extends TestCase
	{
		protected var matcher:Matcher;
		protected var views:SampleViews;
		protected var button:Node;
		protected var oneStyle:Node;
		protected var myStyle:Node;
		
		override protected function setUp():void
		{
			matcher = new Matcher();
			views = new SampleViews();
			button = new Node(Node.CLASS, Button);
			oneStyle = new Node(Node.STYLE, "one");
			myStyle = new Node(Node.STYLE, "myStyle");
		}
		
		override protected function tearDown():void
		{
			matcher = null;
			views = null;
			button = null;
			oneStyle = null;
			myStyle = null;
		}
		
		[Test]
		public function matchStyle():void
		{
			var node:Node = new Node(Node.STYLE, "myStyle");
			
			assertEquals(true, matcher.matchStyle(views.oneButton, node));
			assertEquals(true, matcher.matchStyle(views.twoButton, node));
			assertEquals(false, matcher.matchStyle(views.threeButton, node));
		}
		
		[Test]
		public function matchType():void
		{
			var button:Node = new Node(Node.CLASS, Button);
			
			assertEquals(true, matcher.matchClass(views.oneButton, button));
			assertEquals(false, matcher.matchClass(views.buttonVBox, button));
		}
		
		[Test]
		public function matchBoth():void
		{
			var button:Node = new Node(Node.CLASS, Button);
			var style:Node = new Node(Node.STYLE, "one");
			
			assertEquals(true, matcher.matchNode(views.oneButton, button));
			assertEquals(true, matcher.matchNode(views.oneButton, style));
			
			assertEquals(false, matcher.matchNode(views.twoButton, style));
			assertEquals(false, matcher.matchNode(views.buttonVBox, button));
		}
		
		[Test(a="Matches super classes and interfaces!")]
		public function matchSuperClass():void
		{
			assertEquals(true, matcher.matchNode(views.buttonVBox, views.vbox));
			assertEquals(true, matcher.matchNode(views.buttonVBox, views.container));
			assertEquals(true, matcher.matchNode(views.buttonVBox, views.uicomponent));
			assertEquals(true, matcher.matchNode(views.buttonVBox, views.data));
		}
		
		[Test]
		public function matchTag():void
		{
			assertEquals(true, matcher.matchTag(views.oneButton, views.buttontag));
			assertEquals(true, matcher.matchTag(views.mainVBox, views.vboxtag));
			assertEquals(true, matcher.matchTag(views.mainCanvas, views.canvastag));
			
			assertEquals(false, matcher.matchTag(views.twoButton, views.canvastag));
		}
		
		[Test]
		public function matchID():void
		{
			assertEquals(true, matcher.matchID(views.oneButton, new Node(Node.TAG, "oneButton")));
			assertEquals(true, matcher.matchID(views.mainCanvas, new Node(Node.TAG, "mainCanvas")));
			assertEquals(true, matcher.matchID(views.mainVBox, new Node(Node.TAG, "mainVBox")));
			assertEquals(false, matcher.matchID(views.twoButton, new Node(Node.TAG, "mainVBox")));
		}
		
		[Test]
		public function matchMultiple():void
		{
			var composite:Node = new Node(Node.MULTI, [views.button, views.buttontag, views.one, new Node(Node.ID, "henry2")]);	
			var composite2:Node = new Node(Node.MULTI, [views.button, views.myStyle]);	
			
			assertEquals(true, matcher.matchMultiple(views.henry2, composite));
			assertEquals(false, matcher.matchMultiple(views.henry1, composite));
			
			assertEquals(true, matcher.matchMultiple(views.twoButton, composite2));
		}
		
	}
}