package net.seanhess.bif.core
{
	import flash.utils.getDefinitionByName;
	
	[DefaultProperty("behaviors")]
	public class Selector implements ISelector
	{
		public var debug:Boolean = false;
		
		public function set nodes(value:Array):void
		{
			_nodes = value;
		}
		
		public function get nodes():Array
		{
			return _nodes;
		}
		
		public function set behaviors(value:Array):void
		{
			_behaviors = value;
		}
		
		public function get behaviors():Array
		{
			return _behaviors;
		}
		
		public function set match(value:String):void
		{
			_match = value;
			
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
			
			if (debug) 	trace(" [ G ]   " + this);
			
			this.nodes = nodes;
		}
		
		public function get match():String
		{
			return _match;
		}
		
		public function parseItem(item:String):Node
		{
			var node:Node;
			
			if (item == "*")
				node = new Node(Node.ANY);
				
			else if (item == ">")
				node = new Node(Node.RECURSION_INSTRUCTION, Node.PARENT); // this actually tells
			
			else if (item.indexOf(".") == 0)
				node = new Node(Node.STYLE, item.replace(".",""));				
			
			else if (item.indexOf("#") == 0)
				node = new Node(Node.ID, item.replace("#",""));				
			
			else if (item.match(/^\w+$/)) 	// if all word characters.. 
				node = new Node(Node.TAG, item);
			
			else if (item.match(/^[a-z]+[\w\.]*$/))	// starts with a lower-case letter, then matches any word or '.' chars till the end
				node = new Node(Node.CLASS, getDefinitionByName(item));
			
			else if (item.match(/^[A-Z][\w\.\#\:]*$/))
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
		
		public function toString():String
		{
			return " [ S ]  " + match;
		}
		
		protected var _match:String;
		protected var _behaviors:Array;
		protected var _nodes:Array;
	}
}