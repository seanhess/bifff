package net.seanhess.bifff.behaviors
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import net.seanhess.bifff.utils.Targets;
	
	[Event(name="call", type="flash.events.Event")] 
	public class Listen extends EventDispatcher
	{		
		private var _event:String;
		private var targets:Targets = new Targets();

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
			var dispatcher:IEventDispatcher = target as IEventDispatcher;
			
			if (dispatcher == null)
				throw new Error("Target was not an IEventDispatcher: " + target);
				
			targets.applied(target); 		// remember it was already applied
			
			dispatcher.addEventListener(_event, function(event:Event):void {
				dispatchEvent(new Event("call"));
			});
		}
	}
}