package net.seanhess.bif.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import net.seanhess.bif.utils.Debugger;
	import net.seanhess.bif.utils.Defaults;
	
	/**
	 * I want mate to be able to inject to me, so I'm hacking this to extend UIComponent
	 */
	[DefaultProperty("selectors")]
	[Event(name="foundMatch", type="net.seanhess.bif.core.BifffEvent")]
	public class BehaviorMap extends UIComponent
	{
		public static const STYLES_CHANGED:String = "stylesChanged";
		
		public var registerEvent:String = FlexEvent.CREATION_COMPLETE;
		
		public var debug:Boolean = false;
		public var debugger:Debugger;
		
		public var executor:IExecutor;
				
		public var selectors:Array = [];
		public var matcher:IMatcher = new Matcher();
		public var defaults:Defaults = new Defaults(this);
		
		public function set target(value:IEventDispatcher):void
		{
			if (registered)	unregister();

			if (_target != value)
			{
				if (debug)
					initializeDebugger(value);

				_target = value;	
				commit();
			}
		}
		
		protected function initializeDebugger(target:*):void
		{
			debugger = new Debugger();
			debugger.target = target as DisplayObject;
		}
			
		
		public function get target():IEventDispatcher
		{
			return _target;
		}
		
		private var _target:IEventDispatcher;
		private var registered:Boolean = false;
		
		protected function commit():void
		{
			if (selectors == null || selectors.length == 0)
				selectors = defaults.scan(ISelector);
				
			executor = new Executor(debug);
			
			if (debug)
				executor.addEventListener(BifffEvent.FOUND_MATCH, onFoundMatch, false, 0, true);

			target.addEventListener(registerEvent, onFoundTarget, true, 1, true);
			target.addEventListener(STYLES_CHANGED, onStylesChanged, true, 1, true);
			registered = true;
		}
		
		protected function unregister():void
		{
			target.removeEventListener(registerEvent, onFoundTarget);
			target.addEventListener(STYLES_CHANGED, onStylesChanged);
			executor.removeEventListener(BifffEvent.FOUND_MATCH, onFoundMatch);
			executor = null;
			registered = false;
		}
		
		protected function onFoundMatch(event:BifffEvent):void
		{
			if (debug)
				debugger.match(event.matchedTarget, event.selector);
		}
		
		protected function onStylesChanged(event:Event):void
		{
			onFoundTarget(event);
		}
		
		protected function onFoundTarget(event:Event):void
		{
			var target:* = event.target;
			
			var printed:Boolean = false;
			
			for each (var selector:ISelector in selectors)
				if (matchSelector(target, selector))
					executor.executeSelector(target, selector);
		}
		
		protected function matchSelector(target:*, selector:ISelector):Boolean
		{
			return matcher.match(target as DisplayObject, selector.nodes, this.target as DisplayObject);
		}
		
		public function BehaviorMap()
		{
			this.includeInLayout = false;
			this.visible = false;
			this.width = 0;
			this.height= 0;
		}
		
	}
}