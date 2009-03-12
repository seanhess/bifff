package net.seanhess.bifff.behaviors
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	
	/**
	 * Alerts when you click it 
	 */
	[Event(name="test", type="flash.events.Event")]
	public class TestClick extends EventDispatcher implements IBehavior
	{
		public function set target(value:*):void
		{
			_target = value;
			_target.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function get target():*
		{
			return _target;
		}
		
		protected function onClick(event:Event):void
		{
			Alert.show("Clicked: " + _target);
			dispatchEvent(new Event("test"));
		}
		
		protected var _target:*;
	}
}