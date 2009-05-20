package net.seanhess.bifff.behaviors
{
	import flash.events.Event;
	
	import net.seanhess.bifff.core.Executor;
	import net.seanhess.bifff.core.IExecutor;
	import net.seanhess.bifff.utils.Generator;
	import net.seanhess.bifff.utils.Targets;

	/**
	 * Associates a new instance of a behavior with all targets.
	 * 
	 * This is not a base class. It is a behavior that generates
	 * a behavior for each target 
	 * 
	 * It will create a new behavior based on the class you pass
	 * in on the generator setter.
	 */
	[DefaultProperty("actions")]
	dynamic public class Behavior
	{
		public var creator:Generator;
		public var executor:IExecutor = new Executor();
		private var targets:Targets = new Targets();
		
		public function Behavior()
		{
			creator = new Generator();
			creator.properties = this; // will then read from this object unless overridden
			creator.factory = Event;
		}
		
		public function set target(value:*):void
		{
			if (value)
			{
				targets.add(value);
				apply(value);
			}
		}
		
		public function apply(target:*):void
		{
			var behavior:* = creator.generate();
				
			if (behavior.hasOwnProperty("target"))
				behavior["target"] = target
				
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
	}
}