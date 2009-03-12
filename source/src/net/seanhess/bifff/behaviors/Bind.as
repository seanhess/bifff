package net.seanhess.bif.behaviors
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.binding.utils.ChangeWatcher;
	
	import net.seanhess.bif.core.Executor;
	import net.seanhess.bif.core.IExecutor;
	import net.seanhess.bif.core.Scope;
	
	/**
	 * Executes its behaviors only when a property is changed to a certain value, or any time it is changed
	 * This would probably be more useful if you could do a full binding expression?
	 * 
	 * TODO: Use weak references... Flight?
	 */
	[DefaultProperty("behaviors")]
	public class Bind extends EventDispatcher implements IBehavior
	{
		public static const UPDATE:String = "update";
		
		public var executor:IExecutor = new Executor();
		public var debug:Boolean = false;
		
		public function apply(scope:Scope):void
		{
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
		
		public function set behaviors(value:Array):void
		{
			_behaviors = value;
		}
		
		public function get behaviors():Array
		{
			return _behaviors;
		}
		
		protected function onChange(event:Event):void
		{
			if ((value == null || !event.hasOwnProperty("newValue") || event["newValue"] == value))
			{
				executor.executeBehaviors(event.target, behaviors, new Scope({event:event}));
				
				if (debug)
				{
					dispatchEvent(new Event(UPDATE));
				}				
			}
		}
		
		protected var _behaviors:Array;
		protected var _name:String;
		protected var _value:*;
	}
}