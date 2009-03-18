package net.seanhess.bifff.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.utils.Debugger;
	import net.seanhess.bifff.utils.Defaults;
	import net.seanhess.bifff.utils.Scoper;
	
	/**
	 * I want mate to be able to inject to me, so I'm hacking this to extend UIComponent
	 */
	[DefaultProperty("selectors")]
	[Event(name="foundMatch", type="net.seanhess.bifff.core.BifffEvent")]
	[Event(name="initialize", type="mx.events.FlexEvent")]
	[Bindable]
	public class BehaviorMap extends EventDispatcher implements IMXMLObject
	{
		public static const STYLES_CHANGED:String = "stylesChanged";
		
		public var registerEvent:String = FlexEvent.CREATION_COMPLETE;
		
		public var debug:Boolean = false;
		public var debugger:Debugger;
		
		public var executor:IExecutor;
				
		public var defaults:Defaults = new Defaults(this);
		
		public var document:Object;
		public var id:String;
		
		public var scope:Scope;
		public var scoper:Scoper = new Scoper();
		
		public function BehaviorMap()
		{
			scope = new Scope({map:this});
		}
		
		public function initialized(document:Object, id:String):void
		{
			this.document = document;
			this.id = id;
			dispatchEvent(new FlexEvent(FlexEvent.INITIALIZE));
		}
		
		[Bindable("target")]
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
			
			dispatchEvent(new Event("target"));
		}
		
		public function get target():IEventDispatcher
		{
			return _target;
		}
		
		protected function initializeDebugger(target:*):void
		{
			debugger = new Debugger();
			debugger.target = target as DisplayObject;
		}
			
		
		
		
		private var _target:IEventDispatcher;
		private var registered:Boolean = false;
		
		protected function commit():void
		{			
			scope.mapTarget = target;
			
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
			{
				if (selector.matches(target, this.target))
				{
					executor.executeSelector(target, selector);
					
					if (debug)
					{
						var found:BifffEvent = new BifffEvent(BifffEvent.FOUND_MATCH);
							found.matchedTarget = target;
							found.selector = selector;
							
						dispatchEvent(found);
					}
				}
			}
		}
		
		public function set selectors(value:Array):void
		{
			_selectors = value;	
			scoper.parentScopes(value, scope);				
		}
		
		public function get selectors():Array
		{
			return _selectors;	
		}
		
		protected var _selectors:Array = [];
		
		
		
	}
}