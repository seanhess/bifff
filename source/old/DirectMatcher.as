package net.seanhess.bifff.core
{
	import flash.display.DisplayObject;
	
	import mx.core.Container;
	import mx.core.UIComponent;
	
	/**
	 * This class helps Select, allowing it to find particular nodes
	 */
	public class DirectMatcher
	{
		public var matcher:IMatcher = new Matcher();
		
		public function anscestors(target:DisplayObject, nodes:Array):Array
		{
			if (!target || !target.parent)
				return [];
			
			return matchAnscestor(target.parent, nodes, []);
		}
		
		protected function matchAnscestor(target:DisplayObject, nodes:Array, matched:Array):Array
		{
			if (matcher.match(target, nodes)) // you have to match everything!
				matched.push(target);
				
			if (target.parent)
				matched = matchAnscestor(target.parent, nodes, matched);
				
			return matched;				
		}
		
		
		
		
		
		/**
		 * Matches containers' children
		 */
		public function descendants(target:DisplayObject, nodes:Array):Array
		{
			return matchChildren(target, nodes, []);
		}
		
		protected function matchChildren(target:DisplayObject, nodes:Array, matched:Array):Array
		{
			if (!(target is Container))
				return matched;
			
			var container:Container = target as Container;
			
			if (!container || container.numChildren < 1)
				return matched;
				
			for each (var child:UIComponent in container.getChildren());
				matched = matchDescendant(child, nodes, matched);
				
			return matched;			
		}
		
		protected function matchDescendant(target:DisplayObject, nodes:Array, matched:Array):Array
		{
			if (matcher.match(target, nodes)) // you have to match everything!
				matched.push(target);
				
			matched = matchChildren(target, nodes, matched);
				
			return matched;
		}
	}
}