package magic
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	[DefaultProperty("selectors")]
	public class Listener extends Invalidator
	{
		public var selectors:Array = [];
		public var matcher:IMatcher = new Matcher();
		
		public function set target(value:IEventDispatcher):void
		{
			if (registered)	unregister();
			
			_target = value;	
			newListen = true;
			invalidate();
		}
		
		public function get target():IEventDispatcher
		{
			return _target;
		}
		
		private var _target:IEventDispatcher;
		private var newListen:Boolean = false;
		private var registered:Boolean = false;
		
		override protected function commit():void
		{
			super.commit();
			
			if (newListen)
			{
				newListen = false;
				target.addEventListener(FlexEvent.CREATION_COMPLETE, onFoundTarget, true, 1, true);
				registered = true;
			}
		}
		
		protected function unregister():void
		{
			target.removeEventListener(FlexEvent.CREATION_COMPLETE, onFoundTarget);
			registered = false;
		}
		
		protected function onFoundTarget(event:Event):void
		{
			var target:UIComponent = event.target as UIComponent;
			
			for each (var selector:Selector in selectors)
				matchSelector(target, selector);
		}
		
		protected function matchSelector(target:UIComponent, selector:Selector):void
		{
			if (matcher.match(target, selector.nodes))
				executeRule(target, selector);
		}
		
		protected function executeRule(target:UIComponent, selector:Selector):void
		{
			trace("EXECUTING " + selector + " on " + target);
		}
	}
}