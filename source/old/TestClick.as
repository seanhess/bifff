package net.seanhess.bifff.behaviors
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	
	import net.seanhess.bifff.utils.TargetRegistry;
	
	/**
	 * Alerts when you click it 
	 */
	[Event(name="test", type="flash.events.Event")]
	public class TestClick extends EventDispatcher implements IBehavior
	{
		protected var registry:TargetRegistry = new TargetRegistry(apply);
		
		public function set target(value:*):void
		{
			registry.applyTargets(value);
		}
		
		protected function apply(value:*):void
		{
			value.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:Event):void
		{
			Alert.show(event.target.toString(), "Clicked");
			dispatchEvent(new Event("test"));
		}
	}
}