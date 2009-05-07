package net.seanhess.bifff.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	
	import net.seanhess.bifff.events.CreationComplete;
	import net.seanhess.bifff.utils.Debug;
	import net.seanhess.bifff.utils.Defaults;
	import net.seanhess.bifff.utils.Invalidator;
	
	/**
	 * I want mate to be able to inject to me, so I'm hacking this to extend UIComponent
	 */
	[DefaultProperty("selectors")]
	[Event(name="initialize", type="mx.events.FlexEvent")]
	[Bindable]
	public class BehaviorMap extends EventDispatcher implements IMXMLObject
	{
		public static const STYLES_CHANGED:String = "stylesChanged";
		public static const NEW_TARGET:String = "target";
		public static const MATCHED:String = "matched";
		
		public var registerEvent:String = FlexEvent.CREATION_COMPLETE;
		
		public var executor:IExecutor;
				
		public var defaults:Defaults = new Defaults(this);
		
		public var document:Object;
		public var id:String;
		public var styleName:String = "";
		
		public var invalidator:Invalidator = new Invalidator(finished);
		
		private var parentScope:Scope;
		
		public var scope:CurrentScope = new CurrentScope();
		
		public var autoTarget:Boolean = true;
		
		public function BehaviorMap()
		{
			parentScope = new Scope();
			parentScope.map = this;
		}
		
		[Bindable("target")]
		public function set target(value:IEventDispatcher):void
		{
			if (value && _target != value)
			{
				if (registered)	unregister();
				_target = value;	
				commit();
				dispatchEvent(new Event(NEW_TARGET));
			}
		}
		
		public function get target():IEventDispatcher
		{
			return _target;
		}
		
		/**
		 * Called when created in MXML
		 */
		public function initialized(document:Object, id:String):void
		{
			if (autoTarget && target == null && document is IEventDispatcher)
				target = document as IEventDispatcher;
			
			this.document = document;
			this.id = id;
			dispatchEvent(new FlexEvent(FlexEvent.INITIALIZE));
		}
		
		protected function commit():void
		{			
			if (selectors == null || selectors.length == 0)
				selectors = defaults.scan(ISelector);
				
			executor = new Executor();
			
			parentScope.mapTarget = target;
			
			target.addEventListener(registerEvent, onFoundTargetCapture, true, 1, true);
			target.addEventListener(registerEvent, onFoundTargetNormal, false, 1, true);
			target.addEventListener(STYLES_CHANGED, onStylesChanged, true, 1, true);
			registered = true;
			
			invalidator.invalidate("creationComplete");
		}
		
		/**
		 * Dispatches a creation complete event onto the
		 * target as if we were a visual child of it
		 */
		protected function finished():void
		{
			// Dispatch Fake Creation Complete // 
			var event:CreationComplete = new CreationComplete(this);
			target.dispatchEvent(event);
		}
		
		protected function unregister():void
		{
			target.removeEventListener(registerEvent, onFoundTargetCapture);
			target.removeEventListener(registerEvent, onFoundTargetNormal);
			target.addEventListener(STYLES_CHANGED, onStylesChanged);
			executor = null;
			registered = false;
		}
		
		protected function onStylesChanged(event:Event):void
		{
			match(event.target);
		}
		
		protected function onFoundTargetCapture(event:Event):void
		{
			match(event.target);
		}
		
		protected function onFoundTargetNormal(event:Event):void
		{
			match(event.target);
		}
		
		public function match(target:*):void
		{
			for each (var child:* in selectors)
			{
				var selector:ISelector = child as ISelector;

				if (selector)
				{
					var matched:Boolean = selector.matches(target, this.target); 
					
					if (matched)
						matchedSelector(target, selector);
						
					else
						notMatchedSelector(target, selector);						
				}
			}
		}
		
		public function matchedSelector(target:*, selector:ISelector):void
		{
			executor.executeSelector(target, selector);
			
			if (target is IEventDispatcher)
			{
				(target as IEventDispatcher).dispatchEvent(new Event(MATCHED));
			}
			
			Debug.instance.match(selector, target, true);
		}
		
		public function notMatchedSelector(target:*, selector:ISelector):void
		{
			Debug.instance.match(selector, target, false); 
		}
		
		[ArrayElementType("Object")]
		public function set selectors(value:Array):void
		{
			_selectors = value;	
			
			for each (var selector:ISelector in value)
				initializeSelector(selector);
		}
		
		public function get selectors():Array
		{
			return _selectors;	
		}
		
		protected function initializeSelector(selector:ISelector):void
		{
			selector.parent = parentScope;
		}
		
		protected var _selectors:Array = [];
		private var _target:IEventDispatcher;
		private var registered:Boolean = false;
		
		
	}
}