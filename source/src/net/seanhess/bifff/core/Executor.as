package net.seanhess.bifff.core
{
	import flash.events.EventDispatcher;
	
	import net.seanhess.bifff.actions.IAction;
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
		
		public function executeMatches(matches:Array, actions:Array):void
		{
			for each (var target:* in matches)
				executeActions(target, actions);
		}
		
		public function executeActions(target:*, actions:Array, scope:Scope=null):void
		{
			scope = scope || new Scope();
			
			scope.target = target;
			
			for each (var action:IAction in actions)
				action.apply(scope);
		}
	}
}