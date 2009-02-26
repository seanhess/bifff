package magic
{
	import flash.utils.getDefinitionByName;
	
	public class Rule
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
			
			if (item.indexOf(".") == 0)
			{
				node.type = Node.STYLE
				node.value = item.replace(".","");				
			}
			
			else
			{
				node.type = Node.TYPE;
				node.value = getDefinitionByName(item);				
			}
			
			return node;
		}		
	}
}