package net.seanhess.bifff.behaviors
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import net.seanhess.bifff.core.Executor;
	import net.seanhess.bifff.core.IExecutor;
	import net.seanhess.bifff.scope.IScopeable;
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.utils.Scoper;
	import net.seanhess.bifff.utils.TargetRegistry;
	
	/**
	 * This is going to allow you to listen to events on the object, and add actions as soon as they execute
	 * These actions might just fire another event, or whatever
	 */
	[DefaultProperty("actions")]
	[Event(name="handle", type="flash.events.Event")]
	public class Listener extends EventDispatcher implements IBehavior, IScopeable
	{
		public var executor:IExecutor = new Executor();
		
		public var registry:TargetRegistry = new TargetRegistry(apply);
		public var scope:Scope = new Scope();
		public var scoper:Scoper = new Scoper();
		
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
			if (type == null)
				throw new Error("Listener: type was null");
			
			(target as IEventDispatcher).addEventListener(type, handler);
		}
		
//		public function undo(scope:Scope):void
//		{
//			(target as IEventDispatcher).removeEventListener(type, handler);	
//		}
		
		public function set event(type:String):void
		{
			this.type = type;
		}
		
		public function set actions(value:Array):void
		{
			_actions = value;
		}
		
		public function get actions():Array
		{
			return _actions;
		}
		
		protected function handler(event:Event):void
		{
			if (caught[event])
				return;

			caught[event] = true;
			
			var scope:Scope = new Scope();
				scope.event = event;
				scope.listenerTarget = event.currentTarget;
				scope.parent = this.scope;
			
			scoper.parentScopes(actions, scope);
						
			executor.executeActions(event.currentTarget, actions);
		}
		
		protected var type:String;
		protected var _actions:Array;
		protected var caught:Dictionary = new Dictionary(true);
		
		
	}
}