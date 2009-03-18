package net.seanhess.bifff.behaviors
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import net.seanhess.bifff.core.DirectMatcher;
	import net.seanhess.bifff.core.Executor;
	import net.seanhess.bifff.core.IExecutor;
	import net.seanhess.bifff.core.IParser;
	import net.seanhess.bifff.core.Parser;
	import net.seanhess.bifff.scope.IScopeable;
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.utils.Scoper;
	import net.seanhess.bifff.utils.TargetRegistry;
	
	[DefaultProperty("actions")]
	[Event(name="selected",type="flash.events.Event")]
	/**
	 * Changes the target by setting directly, or searches up or
	 * down the display list to find targets
	 */
	public class Select extends EventDispatcher implements IBehavior, IScopeable
	{
		public static const SEARCH_PARENTS:String = "parents";
		public static const SEARCH_CHILDREN:String = "children"
		public static const SELF:String = "self";
		
		public static const SELECTED:String = "selected";
		
		public var matcher:DirectMatcher = new DirectMatcher();
		public var parser:IParser = new Parser();
		public var executor:IExecutor = new Executor();
		
		public var debug:Boolean = false;
		
		protected var scope:Scope = new Scope();
		protected var scoper:Scoper = new Scoper();
		protected var registry:TargetRegistry = new TargetRegistry(apply);
		
		public function set target(value:*):void
		{
			registry.applyTargets(value);	
		}
		
		public function set parent(value:Scope):void
		{
			scope.parent = value;
		}
		
		public function apply(target:*):void
		{
			scope.target = target;
			
			var targets:Array;
			
			if (matchString == null)
				return;
			
			if (nodes == null)
				nodes = parser.parseMatch(matchString);
				
			if (searchDirection == SEARCH_PARENTS)
				targets = matcher.anscestors(scope.target, nodes);
				
			else if (searchDirection == SEARCH_CHILDREN)
				targets = matcher.descendants(scope.target, nodes);
				
			else if (searchDirection == SELF)
				targets = [target];
				
			else
				throw new Error("Select: Unsupported search direction");
			
			executeMatches(targets);
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
			scoper.parentScopes(value, scope);
		}
		
		protected function executeMatches(matches:Array):void
		{
			if (debug) 	trace(" [ SELECT ] " + matches);
			executor.executeMatches(matches, _actions);
		}
		
		protected var searchDirection:String = SEARCH_PARENTS;
		protected var matchString:String;
		protected var _actions:Array;
		protected var nodes:Array;
	}
}