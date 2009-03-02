package net.seanhess.bif.utils
{
	import mx.core.Container;
	import mx.core.UIComponent;
	
	public class ItemInserter
	{
		protected var invalidator:Invalidator = new Invalidator(commit);
		
		public var replace:Boolean = true;
		
		public function set items(value:Array):void
		{
			_items = value;
			invalidator.invalidate("items");
		}
		
		public function get items():Array
		{
			return _items;	
		}
		
		public function set target(value:Container):void
		{
			_target = value;
		}
		
		public function get target():Container
		{
			return _target;
		}
		
		protected function commit():void
		{
			if (invalidator.invalid("items"))
			{
				if (items && target)
				{
					if (replace)
						target.removeAllChildren();
						
					for each (var child:UIComponent in items)
						target.addChild(child);
				}
			}
		}
		
		protected var _items:Array;
		protected var _target:Container;
	}
}