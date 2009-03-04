package net.seanhess.bif.core
{
	import flash.events.Event;
	
	public class BifffEvent extends Event
	{
		public static const FOUND_MATCH:String = "foundMatch";
		
		public var selector:ISelector;
		public var matchedTarget:*;
		
		public function BifffEvent(type:String)
		{
			super(type);
		}

	}
}