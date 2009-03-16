package net.seanhess.bifff.core
{
	import flash.events.EventDispatcher;
	
	import net.seanhess.bifff.actions.Behavior;
	import net.seanhess.bifff.actions.IAction;
	import net.seanhess.bifff.behaviors.IBehavior;
	import net.seanhess.bifff.scope.Scope;
	
	public class Executor extends EventDispatcher implements IExecutor
	{
		public var applications:ApplicationTracker;
		
		public var debug:Boolean = false;
		
		public function Executor(debug:Boolean = false)
		{
			this.debug = debug;
			applications = new ApplicationTracker();
		}
		
		public function executeSelector(target:*, selector:ISelector):void
		{
			if (applications.applied(selector, target))
				return;
			
			applications.apply(selector, target);

			if (debug)
			{
				var event:BifffEvent = new BifffEvent(BifffEvent.FOUND_MATCH);
					event.selector = selector;
					event.matchedTarget = target;
				
				dispatchEvent(event);
			}
			
			executeActions(target, selector.actions);
		}
		
		public function executeMatches(matches:Array, actions:Array, scope:Scope=null):void
		{
			for each (var target:* in matches)
				executeActions(target, actions, scope);
		}
		
		public function executeActions(target:*, actions:Array, scope:Scope=null):void
		{
			scope = scope || new Scope();
			
			scope.target = target;
			
			// actions can be IActions, Classes (behaviors), or objects that conform to IBehavior (set target)
			for each (var action:Object in actions)
			{
//				var behavior:Behavior;
//				
//				if (!(action is IAction
//				
//				if (action is Class)
//				{
//					behavior = new Behavior();
//					behavior.generator = action;
//					action = behavior;
//				}
//				
//				else if (!(action is IAction))
//				{
//					if (action is IBehavior || action.hasOwnProperty("target") || action.hasOwnProperty("actions")
//				}
				
				if (action is IAction)
					action.apply(scope);
			}
		}
	}
}