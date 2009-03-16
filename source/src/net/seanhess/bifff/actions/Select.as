package net.seanhess.bifff.actions
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import net.seanhess.bifff.core.DirectMatcher;
	import net.seanhess.bifff.core.Executor;
	import net.seanhess.bifff.core.IExecutor;
	import net.seanhess.bifff.core.IParser;
	import net.seanhess.bifff.core.Parser;
	import net.seanhess.bifff.scope.Scope;
	
	[DefaultProperty("actions")]
	[Event(name="selected",type="flash.events.Event")]
	public class Select extends EventDispatcher implements IAction
	{
		public static const SEARCH_PARENTS:String = "parents";
		public static const SEARCH_CHILDREN:String = "children"
		
		public static const SELECTED:String = "selected";
		
		public var matcher:DirectMatcher = new DirectMatcher();
		public var parser:IParser = new Parser();
		public var executor:IExecutor = new Executor();
		
		public var debug:Boolean = false;
		
		public var selectedTargets:Array;
		
		public function apply(scope:Scope):void
		{
			var targets:Array;
			
			if (_targets)
			{
				targets = _targets;
			}
			else
			{
				if (nodes == null)
					nodes = parser.parseMatch(matchString);
					
				if (searchDirection == SEARCH_PARENTS)
					targets = matcher.anscestors(scope.target, nodes);
					
				else if (searchDirection == SEARCH_CHILDREN)
					targets = matcher.descendants(scope.target, nodes);
					
				else
					throw new Error("Select: Unsupported search direction");
			}
			
			selectedTargets = targets;
				
			executeMatches(targets, scope);
			dispatchEvent(new Event(SELECTED));
			return;				
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
		
		protected function executeMatches(matches:Array, scope:Scope):void
		{
			if (debug) 	trace(" [ SELECT ] " + matches);
			executor.executeMatches(matches, _actions, scope);
		}
		
		protected var searchDirection:String = SEARCH_PARENTS;
		protected var matchString:String = "";
		protected var _actions:Array;
		protected var _targets:Array;
		protected var nodes:Array;
	}
}