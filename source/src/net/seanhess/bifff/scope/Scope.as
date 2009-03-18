package net.seanhess.bifff.scope
{
	import net.seanhess.bifff.core.BehaviorMap;
	import net.seanhess.bifff.core.ISelector;
	
	[Bindable]
	/**
	 * Stores anything you want to pass on in the scope, so it can be fetched with 
	 * a smart object
	 */
	dynamic public class Scope
	{
		public static const EVENT:String = "event";
		public static const CURRENT_TARGET:String = "currentTarget";
		public static const BEHAVIOR:String = "behavior";
		public static const BEHAVIOR_TARGET:String = "behaviorTarget";
		public static const LISTENER_TARGET:String = "listenerTarget";
		public static const MAP:String = "map";
		public static const MAP_TARGET:String = "mapTarget";
		public static const SELECTOR:String = "selector";
		
		public var parent:Scope;
		public var map:BehaviorMap;
		public var mapTarget:*;
		public var selector:ISelector;
		public var target:*;
		
		public function Scope(properties:Object=null)
		{
			if (properties)
				for (var property:String in properties)
					this[property] = properties[property];
		}
		
		public function clone():Scope
		{
			var newScope:Scope = new Scope();
			
			for (var property:String in this)
				newScope[property] = this[property];
				
			return newScope;
		}
		
		/**
		 * Just to avoid naming conflicts with BehaviorMap.target
		 */
		public function get currentTarget():*
		{
			return this.target;
		}
	}
}