package net.seanhess.bifff.utils
{
	import flash.utils.Dictionary;
	
	public class TargetRegistry
	{
		public var map:Dictionary = new Dictionary(true);
		public var apply:Function;
		protected var onlyOnce:Boolean = false;
		
		public function TargetRegistry(apply:Function=null, onlyOnce:Boolean=false)
		{
			this.apply = apply;
			this.onlyOnce = onlyOnce;
		}
		
		public function applyTargets(targets:*):void
		{
			if (targets)
			{
				if (targets is Array)
				{
					for each (var item:* in targets)
						checkApply(item);
				}
				else
					checkApply(targets);					
			}
		}	
		
		protected function checkApply(value:*):void
		{
			if (value && (onlyOnce == false || map[value] == null))
			{
				map[value] = {};				
				apply(value);
			}
		}
		
		public function getStore(value:*):Object
		{
			return map[value];
		}
		
		public function removeStore(value:*):void
		{
			delete map[value];
		}
	}
}