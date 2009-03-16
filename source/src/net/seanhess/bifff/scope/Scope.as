package net.seanhess.bifff.scope
{
	import flash.events.Event;
	
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
		
		public function Scope(properties:Object=null)
		{
			if (properties)
				for (var property:String in properties)
					this[property] = properties[property];
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