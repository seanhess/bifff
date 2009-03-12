package net.seanhess.bif.actions
{
	import net.seanhess.bif.core.Scope;
	
	/**
	 * Fetches values from the first or last matched target
	 */
	public class Get implements IBehavior
	{
		/**
		 * The first matched item
		 */
		public var first:*;
		
		/**
		 * The last matched item
		 */
		public var last:*;
		
		public function apply(scope:Scope):void
		{
			first = first || scope.target;
			last = scope.target;
		}
	}
}