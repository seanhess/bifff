package net.seanhess.biff.behaviors
{
	import mx.core.Container;
	import mx.core.UIComponent;
	
	/**
	 * Allows you to replace the contents of your view with new stuff. 
	 * 
	 * Requires that it is a container
	 */
	public class Contents implements IBehavior
	{
		public function add(target:*):void
		{
			var container:Container = target as Container;
			
			if (!container)
				throw new Error("Target is not container " + target);
				
			if (_removeAll)
				container.removeAllChildren();
					
			for each (var childID:String in toRemove)
				if (container[childID] && container.contains(container[childID]))
					container.removeChild(container[childID]);
					
			for each (var child:UIComponent in toAdd)
				container.addChild(child);		
		}
		
		public function remove(target:*):void
		{
			// not implemented for now.. don't want to worry about GC
		}
		
		public function set removeAll(value:Object):void
		{
			_removeAll = true;
		}
		
		/**
		 * Adds children at the end of the display list
		 */
		public function set append(value:Object):void
		{
			if (!(value is Array))
				value = [value];
				
			toAdd = value as Array;
		}
		
		/**
		 * Removes children by id
		 */
		public function set removeChild(value:Object):void
		{
			if (!(value is Array))
				value = [value];
				
			toRemove = value as Array;
		}
		
		/**
		 * replaces all the children with the new ones
		 */
		public function set replace(value:Object):void
		{
			_removeAll = true;
			append = value;
		}
		
		protected var toRemove:Array;
		protected var toAdd:Array;
		protected var toReplace:Array;
		protected var _removeAll:Boolean = false;
	}
}