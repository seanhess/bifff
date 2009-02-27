package net.seanhess.bif.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import net.seanhess.bif.behaviors.IBehavior;
	import net.seanhess.bif.utils.Defaults;
	import net.seanhess.bif.utils.Invalidator;
	
	[DefaultProperty("selectors")]
	public class BehaviorMap
	{
		public var selectors:Array = [];
		public var matcher:IMatcher = new Matcher();
		public var invalidator:Invalidator = new Invalidator(commit, 5);
		public var defaults:Defaults = new Defaults(this);
		
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
				if (selectors == null || selectors.length == 0)
					selectors = defaults.scan(ISelector);

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
			for each (var behavior:IBehavior in selector.behaviors)
				behavior.apply(target);
		}
		
	}
}