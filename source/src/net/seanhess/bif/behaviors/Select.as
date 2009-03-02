package net.seanhess.bif.behaviors
{
	import net.seanhess.bif.core.DirectMatcher;
	import net.seanhess.bif.core.IScope;
	import net.seanhess.bif.core.ISelector;
	import net.seanhess.bif.core.Selector;
	
	[DefaultProperty("behaviors")]
	public class Select implements IBehavior
	{
		public static const SEARCH_PARENTS:String = "parents";
		public static const SEARCH_CHILDREN:String = "children"
		
		public var matcher:DirectMatcher = new DirectMatcher();
		
		public function apply(scope:IScope):void
		{
			generateSelector();
				
			if (searchDirection == SEARCH_PARENTS)
				searchParents(scope.target);
				
			else
				searchChildren(scope.target);
		}

		public function set match(value:String):void
		{
			matchString = value;
		}
		
		public function set direction(value:String):void
		{
			searchDirection = value;
		}
		
		public function set selector(value:ISelector):void
		{
			_selector = value;
		}
		
		public function get selector():ISelector
		{
			return _selector;
		}
		
		public function set behaviors(value:Array):void
		{
			_behaviors = value;
		}
		
		protected function generateSelector():void
		{
			if (selector)	return;
			
			selector = new Selector();
			selector.match = this.matchString;	
		}
		
		protected function searchParents(target:*):void
		{
			var matches:Array = matcher.anscestors(target, selector.nodes);
			executeMatches(matches);
		}
		
		/**
		 * The matching functions aren't quite what I want here... I need to immediately scan down!
		 * Also, it needs to return the matched node, not anything else
		 */
		protected function searchChildren(target:*):void
		{
			
		}
		
		protected function executeMatches(matches:Array):void
		{
			for each (var target:* in matches)
				for each (var behavior:IBehavior in _behaviors)
					behavior.apply(target);
		}
		
		protected var searchDirection:String = SEARCH_PARENTS;
		protected var matchString:String = "";
		protected var _selector:ISelector;
		protected var _behaviors:Array;
	}
}