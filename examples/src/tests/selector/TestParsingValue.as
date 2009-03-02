package tests.selector
{
	import mx.containers.VBox;
	
	import net.digitalprimates.fluint.tests.TestCase;
	import net.seanhess.bif.core.IParser;
	import net.seanhess.bif.core.Node;
	import net.seanhess.bif.core.Parser;
	
	public class TestParsingValue extends TestCase
	{
		protected var rule:IParser;
		
		override protected function setUp():void
		{
			rule = new Parser();
		}
		
		override protected function tearDown():void
		{
			rule = null;
		}
		
		[Test]
		public function parseStyle():void
		{
			var style:Node = rule.parseItem(".style");
			assertEquals("style", style.value);
		}
		
		[Test]
		public function parseID():void
		{
			var id:Node = rule.parseItem("#id");
			assertEquals("id", id.value);
		}
		
		[Test]
		public function parseAny():void
		{
			var node:Node = rule.parseItem("*");
			assertEquals(null, node.value);
		}
		
		[Test]
		public function parseClass():void
		{
			var node:Node = rule.parseItem("mx.containers.VBox");
			assertEquals(VBox, node.value);
		}
		
		[Test]
		public function parseTag():void
		{
			var node:Node = rule.parseItem("Box");
			assertEquals("Box", node.value);
		}
		
		[Test]
		public function parseMulti():void
		{
			var node:Node = rule.parseItem("Box.one");
			var node1:Node = rule.parseItem("Box#one");
			var node2:Node = rule.parseItem("IList.one.two");
			
			assertEquals("Box", node.value[0].value);
			assertEquals("one", node.value[1].value);
			assertEquals("two", node2.value[2].value);
		}
		
		
		
	}
}