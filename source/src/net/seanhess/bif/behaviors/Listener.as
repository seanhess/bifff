package net.seanhess.bif.behaviors
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * This is going to allow you to listen to events on the object, and add behaviors as soon as they execute
	 * These behaviors might just fire another event, or whatever
	 */
	[DefaultProperty("behaviors")]
	public class Listener implements IBehavior
	{
		public function apply(target:*):void
		{
			(target as IEventDispatcher).addEventListener(type, handler, false, 0, true);
		}
		
		public function undo(target:*):void
		{
			(target as IEventDispatcher).removeEventListener(type, handler);	
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
				behavior.apply(event.currentTarget);
			}
		}
		
		protected var type:String;
		protected var _behaviors:Array;
	}
}