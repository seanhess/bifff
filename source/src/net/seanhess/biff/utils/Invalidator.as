package net.seanhess.biff.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	[Event(name="commit", type="flash.events.Event")]
	public class Invalidator extends EventDispatcher
	{
		public static const COMMIT:String = "commit";
		
		protected var invalidProperties:Object = {};
		protected var commitCallback:Function;
		protected var timeout:int = 50;
		
		public function Invalidator(commitCallback:Function, timeout:int = 50)
		{
			this.commitCallback = commitCallback;
			this.timeout = timeout;
		}
		
		protected function commit():void
		{
			if (commitCallback != null)
				commitCallback();
			
			dispatchEvent(new Event(COMMIT));
			invalidProperties = {}; // make sure you use them all!
		}
		
		public function invalidate(property:String=null):void
		{
			if (property)
				invalidProperties[property] = true;
			
			if (invalidationTimer == null)
			{
				invalidationTimer = new Timer(timeout, 1);
				invalidationTimer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
				invalidationTimer.start();
			}
		}
		
		public function invalid(property:String):Boolean
		{
			return invalidProperties[property] != null;
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