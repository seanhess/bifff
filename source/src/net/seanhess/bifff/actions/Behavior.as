package net.seanhess.bifff.actions
{
	import flash.events.Event;
	
	import net.seanhess.bifff.behaviors.IBehavior;
	import net.seanhess.bifff.core.Scope;
	import net.seanhess.bifff.utils.Generator;
	
	/**
	 * Dispatches an event on the target.
	 */
	dynamic public class Behavior implements IAction
	{
		public var debug:Boolean = false;

		public var creator:Generator;
		
		public function Behavior()
		{
			creator = new Generator();
			creator.properties = this; // will then read from us unless overridden
			creator.factory = Event;
		}
		
		public function apply(scope:Scope):void
		{
			var behavior:* = creator.generate(scope);
				
			if (debug)	trace(" [ BEHAVIOR ] " + behavior + " on " + scope.target);
			
			if (behavior is IBehavior)
				(behavior as IBehavior).target = scope.target;
			
			else if (behavior.hasOwnProperty("target"))
				behavior["target"] = scope.target;
				
			else if (behavior.hasOwnProperty("targets"))
				behavior["targets"] = [scope.target];
				
			else
				throw new Error("Could not apply target to behavior: " + behavior);
		}

		/**
		 * The event type. 
		 */
		public function set generator(value:Class):void
		{
			creator.factory = value;
		}
		
		/**
		 * Constructor Arguments - can just pass the first if you want
		 */
		public function set arguments(value:Object):void
		{
			creator.arguments = value;
		}
		
		/**
		 * A list of properties to set on the event before dispatching
		 */
		public function set properties(value:Object):void
		{
			creator.properties = value;
		}
		
		protected var eventType:String;
	}
}