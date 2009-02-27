package net.seanhess.bif.views
{
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	
	/**
	 * Right now this is just syntatic sugar for UIComponent (for swapping). But 
	 * I may add more functionality to this later.
	 * 
	 * Also allows you to copy children from it, even though it isn't a container
	 */
	dynamic public class Item extends UIComponent implements ISimpleItem, IDataRenderer
	{
		protected var _data:Object;
		
		public function set data(value:Object):void
		{
			_data = value;
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function getChildren():Array
		{
			var children:Array = [];
			
			for (var i:int = 0; i < this.numChildren; i++)
				children.push(this.getChildAt(i));
				
			return children;
		}
		
		public function removeAllChildren():void
		{
			
		}
	}
}