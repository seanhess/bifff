package net.seanhess.bifff.events
{
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	/**
	 * A hack on FlexEvent to make it bubble!
	 */
	public class CreationComplete extends FlexEvent
	{
		public var originalTarget:*;
		
		public function CreationComplete(original:*)
		{
			this.originalTarget = original;
			super(FlexEvent.CREATION_COMPLETE, true, false);
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
			var event:CreationComplete = new CreationComplete(originalTarget);
			return event;
		}

	}
}