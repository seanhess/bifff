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
		/**
		 * So we can create a new scope object for our chilluns
		 */
		public var map:BehaviorMap;
		
		public function apply(scope:IScope):void
		{
			if (!map && scope.map)
				map = scope.map;
			
			(scope.target as IEventDispatcher).addEventListener(type, handler, false, 0, true);
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
			for each (var behavior:IBehavior in behaviors)
			{
				behavior.apply(new Scope(event.currentTarget, this.map, event));
			}
		}
		
		protected var type:String;
		protected var _behaviors:Array;
		
	}
}