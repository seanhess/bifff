package net.seanhess.bifff.behaviors
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.binding.utils.ChangeWatcher;
	
	import net.seanhess.bifff.behaviors.IBehavior;
	import net.seanhess.bifff.core.Executor;
	import net.seanhess.bifff.core.IExecutor;
	import net.seanhess.bifff.scope.IScopeable;
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.utils.Scoper;
	import net.seanhess.bifff.utils.TargetRegistry;
	
	/**
	 * Executes its actions only when a property is changed to a certain value, or any time it is changed
	 * This would probably be more useful if you could do a full binding expression?
	 * 
	 * TODO: Use weak references... Flight?
	 */
	[DefaultProperty("actions")]
	public class Bind extends EventDispatcher implements IBehavior, IScopeable
	{
		public static const UPDATE:String = "update";
		
		public var executor:IExecutor = new Executor();
		public var debug:Boolean = false;
		
		public var scopes:Dictionary = new Dictionary(true);
		
		protected var scope:Scope = new Scope();
		protected var registry:TargetRegistry = new TargetRegistry(apply);
		protected var scoper:Scoper = new Scoper();
		
		public function set target(value:*):void
		{
			registry.applyTargets(value);
		}
		
		public function set parent(value:Scope):void
		{
			scope.parent = value;
		}
		
		public function apply(target:*):void
		{
			var watcher:ChangeWatcher = ChangeWatcher.watch(target, property, onChange);
		}
		
		public function set property(value:String):void
		{
			_name = value;
		}
		
		public function get property():String
		{
			return _name;
		}
		
		public function set value(value:*):void
		{
			_value = value;	
		}
		
		public function get value():*
		{
			return _value;
		}
		
		public function set actions(value:Array):void
		{
			_actions = value;
		}
		
		public function get actions():Array
		{
			return _actions;
		}
		
		protected function onChange(event:Event):void
		{
			var target:* = event.target;
			
			if ((value == null || (target[property] == value && (target[property] != registry.getStore(target).value))))
			{
				var scope:Scope = new Scope();
					scope.bindTarget = event.target;
					scope.bindEvent = event;
					scope.target = event.target;
					scope.parent = this.scope;
				
				scoper.parentScopes(actions, scope);
				
				executor.executeActions(target, actions);
				
				if (debug)
				{
					dispatchEvent(new Event(UPDATE));
				}
			}
			
			registry.getStore(target).value = target[property];
		}
		
		protected var _actions:Array;
		protected var _name:String;
		protected var _value:*;
	}
}