package net.seanhess.bif.behaviors
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import net.seanhess.bif.core.Executor;
	import net.seanhess.bif.core.IExecutor;
	import net.seanhess.bif.core.Scope;
	
	/**
	 * This is going to allow you to listen to events on the object, and add behaviors as soon as they execute
	 * These behaviors might just fire another event, or whatever
	 */
	[DefaultProperty("behaviors")]
	[Event("handle")]
	public class Listener extends EventDispatcher implements IBehavior
	{
		public static const HANDLE:String = "handle";
		
		public var debug:Boolean = false;
		public var executor:IExecutor = new Executor();
		
		public function apply(scope:Scope):void
		{
			if (debug) 	trace("[ LISTENING FOR ] \"" + type + "\" on " + scope.target); 
			
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
		
		public function set behaviors(value:Array):void
		{
			_behaviors = value;
		}
		
		public function get behaviors():Array
		{
			return _behaviors;
		}
		
		protected function handler(event:Event):void
		{
			if (debug)	trace(" [ LISTENER ] \"" + type + "\" on " + event.currentTarget + " with a regular target of " + event.target);
						
			executor.executeBehaviors(event.currentTarget, behaviors, new Scope({event:event}));
			
			if (debug)	dispatchEvent(new Event(HANDLE));
		}
		
		protected var type:String;
		protected var _behaviors:Array;
		
	}
}