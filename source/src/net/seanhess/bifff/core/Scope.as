package net.seanhess.bif.core
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
		public static const TARGET:String = "target";
		
		public function Scope(properties:Object=null)
		{
			if (properties)
				for (var property:String in properties)
					this[property] = properties[property];
		}
	}
}