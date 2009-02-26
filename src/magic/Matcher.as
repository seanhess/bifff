package magic
{
	import flash.display.DisplayObject;
	
	import mx.core.UIComponent;
	
	public class Matcher
	{
		/**
		 * To be called once, only at the beginning
		 */
		public function begin(item:DisplayObject, nodes:Array):Boolean
		{
			nodes = nodes.reverse();
			
			if (nodes.length < 1)
				return false;
			
			if (!matchNode(item, nodes[0]))
				return false;
				
			if (nodes.length == 1) // this was the only one
				return true;
			
			return matchRecursive(item.parent, nodes.slice(1));
		}
		
		/**
		 * called once we're on the second item... searching up the tree
		 */
		public function matchRecursive(item:DisplayObject, nodes:Array):Boolean
		{
			var currentNode:Node = nodes[0]; 
			
			if (this.matchNode(item, currentNode))	// we matched the current node
			{
				if (nodes.length == 1)				// this was the last one
					return true;
					
				nodes = nodes.slice(1); 			// get the next one in the list
			}
				
			if (item.parent)
				return matchRecursive(item.parent, nodes);
				
			return false;							// no more parents, return false
		}




		
		
		
		
		
		///// BASIC STUFF ///////
		
		public function matchStyle(item:DisplayObject, node:Node):Boolean
		{
			var comp:UIComponent = item as UIComponent;
			
			if (comp == null || comp.styleName == null)
				return false;

			var styles:Array = comp.styleName.split(" ");
			
			for each (var style:String in styles)
				if (style == node.value)
					return true;
					
			return false;
		}
		
		public function matchClass(item:DisplayObject, node:Node):Boolean
		{
			return item is node.value;
		}
		
		public function matchNode(item:DisplayObject, node:Node):Boolean
		{
			switch(node.type)
			{
				case Node.STYLE:	return matchStyle(item, node);
				case Node.TYPE:		return matchClass(item, node);
				case Node.ANY:		return true;
			}
			
			return false;
		}
	}
}