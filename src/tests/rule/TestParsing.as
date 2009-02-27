package tests.rule
{
	import magic.Node;
	import magic.Selector;
	
	import mx.containers.VBox;
	
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
		public function parseType():void
		{
//			var node:Node = rule.parseItem("VBox");
//			
//			assertEquals(Node.CLASS, node.type);
//			assertEquals(VBox, node.value);
		}
		
	}
}