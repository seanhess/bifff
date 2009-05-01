package net.seanhess.bifff.core
{
	import flash.events.EventDispatcher;
	
	public class Executor extends EventDispatcher implements IExecutor
	{
		public var applications:ApplicationTracker;
		
		public function Executor()
		{
			applications = new ApplicationTracker();
		}
		
		public function executeSelector(target:*, selector:ISelector):void
		{
			if (applications.applied(selector, target))
				return;
			
			applications.apply(selector, target);
			executeActions(target, selector.actions, selector.scope);
		}
		
		public function executeActions(target:*, actions:Array, scope:Scope):void
		{
			for each (var action:Object in actions)
			{
				if (action.hasOwnProperty("target"))
				{
					if (action is IScopeable)
						(action as IScopeable).parent = scope;
						
					action.target = target;
				}
			}
		}
	}
}