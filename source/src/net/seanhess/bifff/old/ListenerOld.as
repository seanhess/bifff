package net.seanhess.bifff.actions
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import net.seanhess.bifff.core.Executor;
	import net.seanhess.bifff.core.IExecutor;
	import net.seanhess.bifff.scope.Scope;
	
	/**
	 * This is going to allow you to listen to events on the object, and add actions as soon as they execute
	 * These actions might just fire another event, or whatever
	 */
	[DefaultProperty("actions")]
	[Event(name="handle", type="flash.events.Event")]
	public class ListenerOld extends EventDispatcher implements IAction
	{
		public static const HANDLE:String = "handle";
		
		public var debug:Boolean = false;
		public var executor:IExecutor = new Executor();
		
		public var scopes:Dictionary = new Dictionary(true);
		
		public function apply(scope:Scope):void
		{
			if (debug) 	trace("[ LISTENING FOR ] \"" + type + "\" on " + scope.target);
			
			scopes[scope.target] = scope; 
			
			(scope.target as IEventDispatcher).addEventListener(type, handler);
		}
		
		public function undo(scope:Scope):void
		{
			(scope.target as IEventDispatcher).removeEventListener(type, handler);	
		}
		
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
			if (debug)	trace(" [ LISTENER ] \"" + type + "\" on " + event.currentTarget + " with a regular target of " + event.target);
						
			var scope:Scope = scopes[event.currentTarget] || new Scope();
				scope.event = event;
				scope.listenerTarget = event.currentTarget;
						
			executor.executeActions(event.currentTarget, actions, scope);
			
			if (debug)	dispatchEvent(new Event(HANDLE));
		}
		
		protected var type:String;
		protected var _actions:Array;
		
	}
}