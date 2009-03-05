package net.seanhess.bif.core
{
	import net.seanhess.bif.behaviors.IBehavior;
	
	/**
	 * Automatically matches and applies the behaviors to the target/targets specified
	 * Can go in or out of a behavior map (doesn't have anything to do with them)
	 */
 	[DefaultProperty("behaviors")]
	public class Apply
	{
		public var executor:IExecutor = new Executor();
		
		/**
		 * Target or targets
		 */
		public function set target(value:Object):void
		{
			if (!(value is Array))
				value = [value];
				
			targets = value as Array;
			
			executor.executeMatches(targets, _behaviors);
		}
		
		public function set behaviors(value:Array):void
		{
			_behaviors = value;
		}
		
		protected var targets:Array;
		protected var _behaviors:Array;
	}
}