package magic
{
	import flash.utils.getDefinitionByName;
	
	[DefaultProperty("nodes")]
	public class Selector
	{
		[Bindable] public var nodes:Array;
		
		public function set match(value:String):void
		{
			var items:Array = value.split(" ");
			var nodes:Array = [];
			
			for each (var item:String in items)
			{
				nodes.push(parseItem(item));
			}
			
			this.nodes = nodes;
		}
		
		public function parseItem(item:String):Node
		{
			var node:Node = new Node();
			
			if (item == "*")
			{
				node.type = Node.ANY;
			}
			
			else if (item.indexOf(".") == 0)
			{
				node.type = Node.STYLE;
				node.value = item.replace(".","");				
			}
			
			else if (item.indexOf("#") == 0)
			{
				node.type = Node.ID;
				node.value = item.replace("#","");
			}
			
			// Parse both CLASS and TAG // The difference is... what? use a try block on getDefinitionByName?
			// Check to see if there is a "." in it
			// Ooh, how will I tell the difference between a fully qualified class, and multiple styleNames?
			// Yikes!
			
			// ALSO add multiples
			
//			else 
//			{
//				node.type = Node.CLASS;
//				node.value = getDefinitionByName(item);				
//			}
			
			return node;
		}
	}
}