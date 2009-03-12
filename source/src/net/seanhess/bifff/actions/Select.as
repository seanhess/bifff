package net.seanhess.bifff.actions
{
	import net.seanhess.bifff.actions.IAction;
	import net.seanhess.bifff.core.DirectMatcher;
	import net.seanhess.bifff.core.Executor;
	import net.seanhess.bifff.core.IExecutor;
	import net.seanhess.bifff.core.IParser;
	import net.seanhess.bifff.core.Parser;
	import net.seanhess.bifff.core.Scope;
	
	[DefaultProperty("actions")]
	public class Select implements IAction
	{
		public static const SEARCH_PARENTS:String = "parents";
		public static const SEARCH_CHILDREN:String = "children"
		
		public var matcher:DirectMatcher = new DirectMatcher();
		public var parser:IParser = new Parser();
		public var executor:IExecutor = new Executor();
		
		public var debug:Boolean = false;
		
		public function apply(scope:Scope):void
		{
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
		
		public function set actions(value:Array):void
		{
			_actions = value;
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
			executor.executeMatches(matches, _actions);
		}
		
		protected var searchDirection:String = SEARCH_PARENTS;
		protected var matchString:String = "";
		protected var _actions:Array;
		protected var _targets:Array;
		protected var nodes:Array;
	}
}