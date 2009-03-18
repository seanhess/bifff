package net.seanhess.bifff.actions
{
	import flash.events.Event;
	
	import mx.events.StateChangeEvent;
	
	/**
	 * Executes its actions only when the currentState is changed
	 */
	public class State extends Listener
	{
		public static const CURRENT_STATE_PROPERTY_NAME:String = "currentState";
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function State()
		{
			super.type = StateChangeEvent.CURRENT_STATE_CHANGE;
		}
		
		override protected function handler(event:Event):void
		{
			var change:StateChangeEvent = event as StateChangeEvent;
			
			if (change.newState == name)
				super.handler(event);
		}
		
		protected var _name:String;
	}
}