package net.seanhess.bifff.behaviors
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	
	/**
	 * Alerts when you click it 
	 */
	public class TestClick implements IBehavior
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
		}
		
		protected var _target:*;
	}
}