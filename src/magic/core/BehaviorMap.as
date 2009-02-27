package magic.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import magic.behaviors.IBehavior;
	import magic.utils.Invalidator;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	[DefaultProperty("selectors")]
	public class BehaviorMap
	{
		public var selectors:Array = [];
		public var matcher:IMatcher = new Matcher();
		public var invalidator:Invalidator = new Invalidator(commit);
		
		public function set target(value:IEventDispatcher):void
		{
			if (registered)	unregister();
			
			_target = value;	
			invalidator.invalidate("target");
		}
		
		public function get target():IEventDispatcher
		{
			return _target;
		}
		
		private var _target:IEventDispatcher;
		private var registered:Boolean = false;
		
		protected function commit():void
		{
			if (invalidator.invalid("target"))
			{
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
			
			for each (var selector:ISelector in selectors)
				matchSelector(target, selector);
		}
		
		protected function matchSelector(target:UIComponent, selector:ISelector):void
		{
			if (matcher.match(target, selector.nodes, this.target as DisplayObject))
				executeRule(target, selector);
		}
		
		protected function executeRule(target:UIComponent, selector:ISelector):void
		{
			trace("EXECUTING " + selector + " on " + target);

			for each (var behavior:IBehavior in selector.behaviors)
				behavior.add(target);
		}
	}
}