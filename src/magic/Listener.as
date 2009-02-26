package magic
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	public class Listener extends Invalidator
	{
		public var rules:Array = [];
		public var matcher:Matcher = new Matcher();
		
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
			
			var matcher:Matcher = new Matcher();
			
			for each (var rule:Rule in rules)
				matchRule(target, rule);
		}
		
		protected function matchRule(target:UIComponent, rule:Rule):void
		{
			if (matcher.begin(target, rule.nodes))
				executeRule(target, rule);
		}
		
		protected function executeRule(target:UIComponent, rule:Rule):void
		{
			trace("EXECUTING " + rule + " on " + target);
		}
	}
}