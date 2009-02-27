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
			
			else if (item.match(/^\w+$/)) 	// if all word characters.. 
			{
				node.type = Node.TAG;
				node.value = item;
			}
			
			else if (item.match(/^[a-z]+[\w\.]*$/))	// starts with a lower-case letter, then matches any word or '.' chars till the end
			{
				node.type = Node.CLASS;
				node.value = getDefinitionByName(item);
			}
			
			else if (item.match(/^[A-Z][\w\.\#]*$/))
			{
				node.type = Node.MULTI;
				node.value = parseMulti(item);
			}
			
			else
			{
				throw new Error("Could not type item ("+item+")");
			}
			
			return node;
		}
		
		public function parseMulti(itemList:String):Array
		{
			var items:Array = itemList.split(/[\.\#]/);
			var nodes:Array = [];
			
			for each (var item:String in items)
			{
				nodes.push(parseItem(item));
			}
			
			return nodes;
		}
	}
}