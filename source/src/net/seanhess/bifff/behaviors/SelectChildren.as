package net.seanhess.bifff.behaviors
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import net.seanhess.bifff.core.BehaviorMap;

	/**
	 * If you have a behavior map that initializes after the children
	 * have already fired, you can use this behavior to search the
	 * display list for matches.
	 * 
	 * Target must be a behavior map. 
	 */
	public class SelectChildren
	{
		private var map:BehaviorMap;
		
		public function set target(value:BehaviorMap):void
		{
			map = value;
			map.addEventListener(BehaviorMap.NEW_TARGET, search, false, 0, true);
			search();
		}
		
		public function search(event:Event = null):void
		{
			if (map.target)
			{
				if (map.target is DisplayObjectContainer)
					searchChildren(map.target as DisplayObjectContainer)
					
				else
					throw new Error("SelectChildren only works if your behavior map target is a container");
			}
		}
		
		protected function searchChildren(node:DisplayObjectContainer):void
		{
			for (var i:int = 0; i < node.numChildren; i++)
			{
				var child:DisplayObject = node.getChildAt(i);
				map.match(child);
				
				if (child is DisplayObjectContainer)
					searchChildren(child as DisplayObjectContainer);
			}
		}
	}
}