package magic.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Invalidator extends EventDispatcher
	{
		protected function commit():void
		{
			
		}
		
		protected function invalidate():void
		{
			if (invalidationTimer == null)
			{
				invalidationTimer = new Timer(50, 1);
				invalidationTimer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
				invalidationTimer.start();
			}
		}
		
		protected function onTimer(event:Event):void
		{
			invalidationTimer.removeEventListener(TimerEvent.TIMER, onTimer);
			invalidationTimer = null;	
			
			commit();
		}
		
		protected var invalidationTimer:Timer;
	}
}