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
			executeBehaviors(target, selector.actions, selector.scope);
		}
		
		public function executeBehaviors(target:*, behaviors:Array, scope:Scope):void
		{
			for each (var behavior:Object in behaviors)
			{
				if (behavior.hasOwnProperty("target"))
				{
					setBehaviorParent(behavior, scope);
					behavior.target = target;
				}
			}
		}
		
		protected function setBehaviorParent(behavior:*, scope:Scope):void
		{
			if (behavior is IScopeable)
				(behavior as IScopeable).parent = scope;
		}
	}
}