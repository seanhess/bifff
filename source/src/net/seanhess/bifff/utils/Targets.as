package net.seanhess.bifff.utils
{
	import flash.utils.Dictionary;
	
	/**
	 * Utility to work with multiple targets.
	 */
	public class Targets
	{
		public static const APPLIED:int = 0;
		public static const NEW:int = 1;
		
		protected var targets:Dictionary = new Dictionary(true);
		protected var store:Dictionary = new Dictionary(true);
		
		public function add(target:*):void
		{
			targets[target] = NEW;
		}
		
		public function getStore(target:*):*
		{
			return store[target];
		}
		
		public function setStore(target:*, data:*):void
		{
			store[target] = true;
		}
		
		public function eachTarget(callback:Function):void
		{
			for (var target:* in targets)
			{
				callback(target);
			}
		}
		
		public function eachUnapplied(callback:Function):void
		{
			for (var target:* in targets)
			{
				if (targets[target] == NEW)
					callback(target);
			}
		}
		
		public function applied(target:*):void
		{
			targets[target] = APPLIED;
		}
	}
}