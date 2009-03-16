package net.seanhess.bifff.core
{
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	
	public class Matcher implements IMatcher
	{
		/**
		 * To be called once, only at the beginning
		 */
		public function match(item:DisplayObject, nodes:Array, root:DisplayObject=null):Boolean
		{
			if (!item)
				return false;
			
			if (nodes.length < 1)
				return false;
				
			var node:Node = last(nodes);
			
			switch(node.recursion)
			{
				case Node.NONE:			
				case Node.PARENT:		return matchNone(item, nodes, root);
				case Node.ANCESTOR:		return matchAncestor(item, nodes, root);
				
				default:
					throw new Error("Unkown recursion for node " + node);
			}
		}
		
		public function matchNone(item:DisplayObject, nodes:Array, root:DisplayObject = null):Boolean
		{
			if (!matchNode(item, last(nodes)))
				return false;
				
			if (nodes.length == 1) // this was the only one
				return true;
				
			if (item == root)
				return false;
				
			return match(item.parent, next(nodes), root);
		}
		
		public function matchAncestor(item:DisplayObject, nodes:Array, root:DisplayObject = null):Boolean
		{
			if (item == null)
				return false;
			
			var currentNode:Node = last(nodes) 
			
			if (this.matchNode(item, currentNode))	// we matched the current node
			{
				if (nodes.length == 1)				// this was the last one
					return true;
					
				nodes = next(nodes)		 			// get the next one in the list
			}
				
			if (item.parent && item != root)
				return match(item.parent, nodes, root);
				
			return false;							// no more parents, return false
		}



		
		
		
		
		
		///// BASIC STUFF ///////
		
		public function matchStyle(item:DisplayObject, node:Node):Boolean
		{
			var comp:* = item;
			
			if (comp == null || !comp.hasOwnProperty("styleName") || comp.styleName == null)
				return false;
				
			var styleName:String = comp.styleName;
			
			if (styleName == null)
				return false;

			var styles:Array = styleName.split(" ");
			
			for each (var style:String in styles)
				if (style == node.value)
					return true;
					
			return false;
		}
		
		/**
		 * Matches an exact type
		 */
		public function matchClass(item:DisplayObject, node:Node):Boolean
		{
			return item is node.value;
		}
		
		/**
		 * Matches the shallow class name "VBox" of the item. 
		 */
		public function matchTag(item:DisplayObject, node:Node):Boolean
		{
			var className:String = getQualifiedClassName(item);
			
			var regex:RegExp = new RegExp(node.value + "$");
			return regex.test(className);
		}
		
		/**
		 * Matches the ID
		 */
		public function matchID(item:DisplayObject, node:Node):Boolean
		{
			if (!item.hasOwnProperty("id"))
				return false;
				
			return item["id"] == node.value; 
		}
		
		public function matchMultiple(item:DisplayObject, node:Node):Boolean
		{
			var nodes:Array = node.value as Array;
			
			for each (var singleNode:Node in nodes)
				if (!matchNode(item, singleNode))
					return false;
					
			return true; // if they have all matched
		}
		
		public function matchMeta(item:DisplayObject, node:Node):Boolean
		{
			if (!(item.parent))
				return false;
				
			if (node.value == "even" && (item.parent.getChildIndex(item) % 2 == 0))
				return true;
			
			else if (node.value == "odd" && (item.parent.getChildIndex(item) % 2 == 1))
				return true;
			
			else
				return false;
		}
		
		public function matchNode(item:DisplayObject, node:Node):Boolean
		{
			switch(node.type)
			{
				case Node.CLASS:	return matchClass(item, node);
				case Node.TAG:		return matchTag(item, node);
				case Node.ID:		return matchID(item, node);
				case Node.STYLE:	return matchStyle(item, node);
				case Node.MULTI:	return matchMultiple(item, node);
				case Node.META:		return matchMeta(item, node);
				case Node.INSTANCE:	return item == node.value;
				case Node.ANY:		return true;
			}
			
			return false;
		}
		
		public function last(nodes:Array):Node
		{
			return nodes[nodes.length-1];			
		}
		
		public function next(nodes:Array):Array
		{
			return nodes.slice(0, nodes.length-1);
		}
	}
}