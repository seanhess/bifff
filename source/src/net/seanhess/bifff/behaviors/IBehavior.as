package net.seanhess.bifff.behaviors
{
	/**
	 * Allows you to set a target to apply youself to
	 */
	public interface IBehavior
	{
		/**
		 * Can be set to an array or a single target (or a scope?)
		 * 
		 * The problem is that with my framework, I might be setting
		 * it to multiples at different times. 
		 * 
		 * It would be a lot easier if I only ever set it to one. 
		 * 
		 * Thomas' stuff would still work
		 */
		function set target(value:*):void;
	}
}