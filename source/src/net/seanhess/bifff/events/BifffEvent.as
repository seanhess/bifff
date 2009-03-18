package net.seanhess.bifff.events
{
	import flash.events.Event;
	
	import net.seanhess.bifff.core.ISelector;
	
	public class BifffEvent extends Event
	{
		public static const FOUND_MATCH:String = "foundMatch";
		public static const UPDATED_STYLE:String = "updatedStyle";
		
		public var selector:ISelector;
		public var matchedTarget:*;
		
		public function BifffEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			var newEvent:BifffEvent = new BifffEvent(type);
				newEvent.selector = selector
				newEvent.matchedTarget = matchedTarget;
				
			return newEvent;
		}

	}
}