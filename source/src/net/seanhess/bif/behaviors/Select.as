package net.seanhess.bif.behaviors
{
	import net.seanhess.bif.core.BehaviorMap;
	import net.seanhess.bif.core.DirectMatcher;
	import net.seanhess.bif.core.IParser;
	import net.seanhess.bif.core.IScope;
	import net.seanhess.bif.core.Parser;
	import net.seanhess.bif.core.Scope;
	
	[DefaultProperty("behaviors")]
	public class Select implements IBehavior
	{
		public static const SEARCH_PARENTS:String = "parents";
		public static const SEARCH_CHILDREN:String = "children"
		
		public var matcher:DirectMatcher = new DirectMatcher();
		public var parser:IParser = new Parser();
		
		public var debug:Boolean = false;
		
		public function apply(scope:IScope):void
		{
			if (map == null && scope.map)
				map = scope.map;
			
			if (_targets)
			{
				executeMatches(_targets);
				return;				
			}
			
			if (nodes == null)
				nodes = parser.parseMatch(matchString);
				
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
		
		public function set behaviors(value:Array):void
		{
			_behaviors = value;
		}
		
		/**
		 * not implemented 
		 */
		public function set target(value:Object):void
		{
			if (value && !(value is Array))
				value = [value];
			
			_targets = value as Array;
		}
		
		protected function searchParents(target:*):void
		{
			var matches:Array = matcher.anscestors(target, nodes);
						
			executeMatches(matches);
		}
		
		/**
		 * Not Implemented Yet
		 */
		protected function searchChildren(target:*):void
		{
			
		}
		
		protected function executeMatches(matches:Array):void
		{
			if (debug) 	trace(" [ SELECT ] " + matches);
			
			for each (var target:* in matches)
				for each (var behavior:IBehavior in _behaviors)
					behavior.apply(new Scope(target, this.map));
		}
		
		protected var searchDirection:String = SEARCH_PARENTS;
		protected var matchString:String = "";
		protected var _behaviors:Array;
		protected var _targets:Array;
		protected var nodes:Array;
		protected var map:BehaviorMap;
	}
}