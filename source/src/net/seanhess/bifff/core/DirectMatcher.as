package net.seanhess.bif.core
{
	import flash.display.DisplayObject;
	
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
		
		
		
		
		
		
		
		public function descendants(target:DisplayObject, nodes:Array):Array
		{
			throw new Error("descendants not implemented yet");
			return [];
		}
		
		protected function matchDescendant(target:DisplayObject, nodes:Array, matched:Array):Array
		{
			return [];
		}
	}
}