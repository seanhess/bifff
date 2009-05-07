package net.seanhess.bifff.behaviors
{
	/**
	 * Inject is the same as set, but it can only set properties
	 * and throws an error if the property is not available or 
	 * writable.
	 */
	dynamic public class Inject extends Set
	{
		/**
		 * Don't set the style, just throw an error. 
		 */
		override protected function setStyleOnTarget(target:*, property:String, value:*):void
		{
			throw new Error("Could not set property '"+property+"' on target '"+target+"' to value '"+value+"'");
		}
	}
}