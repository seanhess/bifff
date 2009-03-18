package net.seanhess.bifff.actions
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.binding.utils.ChangeWatcher;
	
	import net.seanhess.bifff.core.Executor;
	import net.seanhess.bifff.core.IExecutor;
	import net.seanhess.bifff.scope.Scope;
	
	/**
	 * Executes its actions only when a property is changed to a certain value, or any time it is changed
	 * This would probably be more useful if you could do a full binding expression?
	 * 
	 * TODO: Use weak references... Flight?
	 */
	[DefaultProperty("actions")]
	public class Bind extends EventDispatcher implements IAction
	{
		public static const UPDATE:String = "update";
		
		public var executor:IExecutor = new Executor();
		public var debug:Boolean = false;
		
		public var scopes:Dictionary = new Dictionary(true);
		
		public function apply(scope:Scope):void
		{
			scopes[scope.target] = scope;
			var watcher:ChangeWatcher = ChangeWatcher.watch(scope.target, property, onChange);
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
			if ((value == null || !event.hasOwnProperty("newValue") || event["newValue"] == value))
			{
				var scope:Scope = scopes[event.currentTarget] || new Scope();
					scope.bindTarget = event.target;
					scope.event = event;
				
				executor.executeActions(event.target, actions, scope);
				
				if (debug)
				{
					dispatchEvent(new Event(UPDATE));
				}				
			}
		}
		
		protected var _actions:Array;
		protected var _name:String;
		protected var _value:*;
	}
}