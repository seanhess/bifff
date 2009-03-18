package net.seanhess.bifff.utils
{
	import flash.utils.Dictionary;
	
	public class TargetRegistry
	{
		protected var map:Dictionary = new Dictionary(true);
		protected var apply:Function;
		
		public function TargetRegistry(apply:Function=null)
		{
			this.apply = apply;
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
					apply(targets);					
			}
		}	
		
		protected function checkApply(value:*):void
		{
			if (value && map[value] == null)
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