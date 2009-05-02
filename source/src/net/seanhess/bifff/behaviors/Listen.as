package net.seanhess.bifff.behaviors
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import net.seanhess.bifff.core.IScopeable;
	import net.seanhess.bifff.core.Scope;
	import net.seanhess.bifff.utils.Targets;
	
	[Event(name="call", type="flash.events.Event")] 
	[Bindable]
	public class Listen extends EventDispatcher implements IScopeable
	{		
		private var _event:String;
		private var targets:Targets = new Targets();
		
		public var parent:Scope = new Scope();	// a parent can set this from the outside

		public function set target(value:*):void
		{			
			if (value == null) return;
			
			targets.add(value);
			
			if (_event)	apply(value);		// if event has already been set
		}

		public function set event(value:String):void
		{
			_event = value;
			targets.eachUnapplied(apply);	// if this was set later than the targets
		}
		
		public function apply(target:*):void
		{
			var dispatcher:IEventDispatcher = getDispatcher(target);
				
			targets.applied(target); 		// remember it was already applied
			
			dispatcher.addEventListener(_event, function(event:Event):void {
				generateScope(target, event);
				dispatchEvent(new Event("call"));
			});
		}
		
		protected function getDispatcher(target:*):IEventDispatcher
		{
			var dispatcher:IEventDispatcher = target as IEventDispatcher;
			
			if (dispatcher == null)
				throw new Error("Target was not an IEventDispatcher: " + target);
				
			return dispatcher;
		}
		
		protected function generateScope(target:*, event:Event):void
		{
			var scope:Scope = new Scope();
				scope.parent = parent;
				scope.event = event;
				scope.target = target;
					
			Scope.current = scope;
		}
	}
}