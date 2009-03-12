package net.seanhess.bifff.core
{
	import flash.utils.getDefinitionByName;
	
	public class Parser implements IParser
	{
		public function parseMatch(value:String):Array
		{
			// I took this out when I added the apply tag
//			if (!(value is String))
//			{
//				var instance:Node = new Node(Node.INSTANCE, value);
//					instance.recursion = Node.NONE;
//					
//				return [instance];	
//			}
			
			var items:Array = value.split(" ");
			var nodes:Array = [];
			
			for (var index:int = 0; index < items.length; index ++)
			{
				var item:String = items[index];
				var node:Node = parseItem(item);
				
				if (node.type == Node.RECURSION_INSTRUCTION)
				{
					(nodes[index-1] as Node).recursion = node.value;
					continue;
				}
				
				nodes.push(node);
			}
			
			(nodes[nodes.length-1] as Node).recursion = Node.NONE;
			
			return nodes;
		}
		
		public function parseItem(item:String):Node
		{
			var node:Node;
			
			if (item == "*")
				node = new Node(Node.ANY);
				
			else if (item == ">")
				node = new Node(Node.RECURSION_INSTRUCTION, Node.PARENT); // this actually tells
			
			else if (item.match(/^\.[a-zA-Z0-9_]+$/))
				node = new Node(Node.STYLE, item.replace(".",""));				
			
			else if (item.match(/^\#[a-zA-Z0-9_]+$/))
				node = new Node(Node.ID, item.replace("#",""));				
			
			else if (item.match(/^[a-zA-Z0-9_]+$/)) 	// if all word characters.. 
				node = new Node(Node.TAG, item);
			
			else if (item.match(/^[a-z]+[a-zA-Z0-9_\.]*$/))	// starts with a lower-case letter, then matches any word or '.' chars till the end
				node = new Node(Node.CLASS, getDefinitionByName(item));
			
			else if (item.match(/^[A-Z\.\#][\w\.\#\:]*$/))
				node = new Node(Node.MULTI, parseMulti(item));
			
			else
				throw new Error("Could not type item ("+item+")");
			
			return node;
		}
		
		public function parseMulti(itemList:String):Array
		{
			var items:Array = itemList.split(/(\.|\#|\:)/);
			var nodes:Array = [];
			
			var nextIsStyle:Boolean = false;
			var nextIsID:Boolean = false;
			var nextIsMeta:Boolean = false;
			
			for each (var item:String in items)
			{
				if (item == "")
					continue;
				
				if (item == "#")
				{
					nextIsID = true;
					nextIsStyle = false;
					nextIsMeta = false;
					continue;
				}
				
				if (item == ".")
				{
					nextIsStyle = true;
					nextIsID = false;
					nextIsMeta = false;
					continue;
				}
				
				if (item == ":")
				{
					nextIsMeta = true;
					nextIsID = false;
					nextIsStyle = false;
					continue;
				}
				
				var value:Node;
				
				if (nextIsStyle)
					value = new Node(Node.STYLE, item);
				
				else if (nextIsID)
					value = new Node(Node.ID, item);
					
				else if (nextIsMeta)
					value = new Node(Node.META, item);
					
				else 
					value = parseItem(item);
				
				nodes.push(value);
				
				nextIsID = false;
				nextIsStyle = false;
				nextIsMeta = false;
			}
			
			return nodes;
		}
	}
}