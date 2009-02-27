package tests.selector
{
	import magic.core.Node;
	import magic.core.Selector;
	
	import net.digitalprimates.fluint.tests.TestCase;
	
	public class TestParsing extends TestCase
	{
		protected var rule:Selector;
		
		override protected function setUp():void
		{
			rule = new Selector();
		}
		
		override protected function tearDown():void
		{
			rule = null;
		}
		
		[Test]
		public function parseStyle():void
		{
			var style:Node = rule.parseItem(".style");
			assertEquals(Node.STYLE, style.type);
		}
		
		[Test]
		public function parseID():void
		{
			var id:Node = rule.parseItem("#id");
			assertEquals(Node.ID, id.type);
		}
		
		[Test]
		public function parseAny():void
		{
			var node:Node = rule.parseItem("*");
			assertEquals(Node.ANY, node.type);
		}
		
		[Test]
		public function parseClass():void
		{
			var node:Node = rule.parseItem("mx.containers.VBox");
			assertEquals(Node.CLASS, node.type);
		}
		
		[Test]
		public function parseTag():void
		{
			var node:Node = rule.parseItem("Box");
			assertEquals(Node.TAG, node.type);
		}
		
		[Test]
		public function parseMulti():void
		{
			var node:Node = rule.parseItem("Box.one");
			var node1:Node = rule.parseItem("Box#one");
			var node2:Node = rule.parseItem("IList.one.two");
			
			assertEquals(Node.MULTI, node.type);
			assertEquals(Node.MULTI, node1.type);
			assertEquals(Node.MULTI, node2.type);

			assertEquals(Node.TAG, 	 node.value[0].type);
			assertEquals(Node.TAG, 	 node1.value[0].type);
			assertEquals(Node.STYLE, node.value[1].type);
			assertEquals(Node.ID, 	 node1.value[1].type);
			assertEquals(Node.STYLE, node2.value[1].type);
			assertEquals(Node.STYLE, node2.value[2].type);


		}
		
		
		
	}
}