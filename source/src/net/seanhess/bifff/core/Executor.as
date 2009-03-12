package net.seanhess.bif.core
{
	import flash.events.EventDispatcher;
	
	import net.seanhess.bif.behaviors.IBehavior;
	
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
			
			executeBehaviors(target, selector.behaviors);
		}
		
		public function executeMatches(matches:Array, behaviors:Array):void
		{
			for each (var target:* in matches)
				executeBehaviors(target, behaviors);
		}
		
		public function executeBehaviors(target:*, behaviors:Array, scope:Scope=null):void
		{
			scope = scope || new Scope();
			
			scope.target = target;
			
			for each (var behavior:IBehavior in behaviors)
				behavior.apply(scope);
		}
	}
}