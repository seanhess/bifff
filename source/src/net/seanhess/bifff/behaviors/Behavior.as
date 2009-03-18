package net.seanhess.bifff.behaviors
{
	import flash.events.Event;
	
	import net.seanhess.bifff.core.Executor;
	import net.seanhess.bifff.core.IExecutor;
	import net.seanhess.bifff.scope.IScopeable;
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.utils.Generator;
	import net.seanhess.bifff.utils.Scoper;
	import net.seanhess.bifff.utils.TargetRegistry;
	
	/**
	 * Associates a new instance of a behavior with all targets.
	 * 
	 * This is not a base class. It is a behavior that creates 
	 * another behavior and associates it with the targets
	 * 
	 * It will create a new behavior based on the class you pass
	 * in on the generator setter.
	 */
	[DefaultProperty("actions")]
	dynamic public class Behavior implements IBehavior, IScopeable
	{
		public var debug:Boolean = false;

		public var creator:Generator;
		public var executor:IExecutor = new Executor();
		public var registry:TargetRegistry = new TargetRegistry(apply, true);
		public var scope:Scope = new Scope();
		public var scoper:Scoper = new Scoper();
		
		public function Behavior()
		{
			creator = new Generator();
			creator.properties = this; // will then read from us unless overridden
			creator.factory = Event;
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
				
			scope.behavior = behavior;
			scope.behaviorTarget = target;
				
			executor.executeActions(behavior, actions);
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
		
		public function set actions(value:Array):void
		{
			_actions = value;
			scoper.parentScopes(value, scope);
		}
		
		public function get actions():Array
		{
			return _actions;
		}
		
		protected var eventType:String;
		protected var _actions:Array;
	}
}