package net.seanhess.bif.behaviors
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import net.seanhess.bif.core.BehaviorMap;
	import net.seanhess.bif.core.IScope;
	import net.seanhess.bif.core.Scope;
	
	/**
	 * This is going to allow you to listen to events on the object, and add behaviors as soon as they execute
	 * These behaviors might just fire another event, or whatever
	 */
	[DefaultProperty("behaviors")]
	public class Listener implements IBehavior
	{
		public var debug:Boolean = false;
		
		public function apply(scope:IScope):void
		{
			if (debug) 	trace("[ LISTENING FOR ] \"" + type + "\" on " + scope.target); 
			
			(scope.target as IEventDispatcher).addEventListener(type, handler);
		}
		
		public function undo(scope:IScope):void
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
			
			for each (var behavior:IBehavior in behaviors)
			{
				behavior.apply(new Scope(event.currentTarget, event));
			}
		}
		
		protected var type:String;
		protected var _behaviors:Array;
		
	}
}