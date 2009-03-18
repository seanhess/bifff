package net.seanhess.bifff.behaviors
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import net.seanhess.bifff.scope.IScopeable;
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.utils.Generator;
	import net.seanhess.bifff.utils.TargetRegistry;
	
	/**
	 * Dispatches an event on the target.
	 */
	dynamic public class Dispatch implements IBehavior, IScopeable
	{
		public var debug:Boolean = false;
		
		protected var scope:Scope = new Scope();
		protected var registry:TargetRegistry = new TargetRegistry(apply);

		public var creator:Generator;
		public var defaultArguments:Array;
		
		public function Dispatch()
		{
			defaultArguments = ["nothing", false];
			
			creator = new Generator();
			creator.properties = this; // will then read from us unless overridden
			creator.factory = Event;
			creator.arguments = defaultArguments;
		}
		
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
			
			var event:Event = creator.generate(scope) as Event;
				
			if (debug)	trace(" [ DISPATCH EVENT ] " + event + " on " + scope.target);
				
			(scope.target as IEventDispatcher).dispatchEvent(event);			
		}

		/**
		 * The event type. 
		 */
		public function set generator(value:Class):void
		{
			creator.factory = value;
		}
		
		/**
		 * Bubbling
		 */
		public function set bubbles(value:Boolean):void
		{
			defaultArguments[1] = value;
		}
		
		/**
		 * Constructor Arguments - can just pass the first if you want
		 */
		public function set arguments(value:Object):void
		{
			creator.arguments = value;
		}
		
		/**
		 * Alias to set the first constructor argument?
		 */
		public function set type(value:String):void
		{
			defaultArguments[0] = value;
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