package net.seanhess.bif.views
{
	import mx.core.UIComponent;
	
	/**
	 * Right now this is just syntatic sugar for UIComponent (for swapping). But 
	 * I may add more functionality to this later.
	 * 
	 * Also allows you to copy children from it, even though it isn't a container
	 * 
	 * <Item label="henry" styleName="Josh">
	 *   <Item label="child1"/>
	 * </Item>
	 * 
	 * Sets the data property of the view you choose to a big ol' combination of all this stuff
	 * 
	 */
	[DefaultProperty("items")]
	dynamic public class Item extends UIComponent implements ISimpleItem
	{
		public function set items(value:Array):void
		{
			_items = value;
		}
		
		public function get items():Array
		{
			return _items;
		}
		
		public function get data():Object
		{
			var obj:Object = {};
			
			// GET DYNAMIC PROPERTIES // 
			for (var property:String in this) 
				obj[property] = this[property];
			
			// GET ITEMS // 
			obj.items = this.items;
			
			return obj;
		}
		
		public var renderChildren:Boolean = false;
		
		public var _items:Array;
	}
}