package net.seanhess.bifff.extensions
{
	import flash.utils.Dictionary;
	
	import net.seanhess.bifff.core.BehaviorMap;
	
	public class CachingBehaviorMap extends BehaviorMap
	{
		protected var found:Dictionary = new Dictionary(true);
		
		override public function match(target:*):void
		{
			found[target] = true;
			super.match(target);
		}
		
		/**
		 * Selectors shouldn't be set very regularly. Besides, the
		 * executor will prevent us from executing twice. 
		 */
		override public function set selectors(value:Array):void
		{
			super.selectors = value;
			
			for (var target:* in found)
				super.match(target);
		}
	}
}