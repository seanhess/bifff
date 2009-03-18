package net.seanhess.bifff.events
{
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	public class HijackedEvent extends FlexEvent
	{
		public var originalTarget:*;
		
		public function HijackedEvent(type:String, bubbling:Boolean=false)
		{
			super(type, bubbling);
		}
		
		override public function get target():Object
		{
			return originalTarget;
		}
		
		override public function get currentTarget():Object
		{
			return originalTarget;
		}
		
		override public function clone():Event
		{
			var event:HijackedEvent = new HijackedEvent(type);
				event.originalTarget = this.originalTarget;
				
			return event;
		}

	}
}