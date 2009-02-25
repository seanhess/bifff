package magic
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	import mx.events.FlexEvent;
	
	public class Listener extends Invalidator
	{
		public var dispatcher:IEventDispatcher;
		
		public function set target(value:Class):void
		{
			if (registered)	unregister();
			
			_target = value;	
			newListen = true;
			invalidate();
		}
		
		public function get target():Class
		{
			return _target;
		}
		
		private var _target:Class;
		private var newListen:Boolean = false;
		private var registered:Boolean = false;
		
		
		override protected function commit():void
		{
			super.commit();
			
			if (newListen)
			{
				newListen = false;
				
//				var type:String = getQualifiedClassName(target);
				
				dispatcher.addEventListener(FlexEvent.CREATION_COMPLETE, onFoundTarget, true, 1, true);
				registered = true;
			}
		}
		
		protected function unregister():void
		{
//			var type:String = getQualifiedClassName(target);
			dispatcher.removeEventListener(FlexEvent.CREATION_COMPLETE, onFoundTarget);
			registered = false;
		}
		
		protected function onFoundTarget(event:Event):void
		{
			var bob:Boolean = true;
		}

	}
}