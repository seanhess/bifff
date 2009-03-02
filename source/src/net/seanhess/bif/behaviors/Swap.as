package net.seanhess.bif.behaviors
{
	import flash.display.DisplayObjectContainer;
	
	import mx.core.Container;
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	
	import net.seanhess.bif.views.ISimpleItem;
	
	/**
	 * Swaps you out with another view, copies your children
	 * if both are containers, 
	 * 
	 * More importantly, it copies the data, allowing you 
	 * to create views with nothing in them but a data 
	 * property, and swap them out with a renderer
	 */
	public class Swap implements IBehavior
	{
		public function apply(target:*):void
		{
			if (!_view)	throw new Error("View was not set");
			
			var newView:* = new _view();
			
			if (target is UIComponent && newView is UIComponent)
			{
				newView.styleName = target.styleName; // should merge styles, not replace them!
				newView.id = target.id;
			}
			
			if ((target is IDataRenderer || target is ISimpleItem) && newView is IDataRenderer)
				newView.data = target.data; 
			
			if (target is Container && newView is Container) // this will not  happen for ISimpleItems
			{
				var children:Array = target.getChildren();
				target.removeAllChildren();
				
				for each (var child:UIComponent in children)
					newView.addChild(child);
			}
			
			if (target.parent)
			{
				var parent:DisplayObjectContainer = target.parent as DisplayObjectContainer;
				var index:int = parent.getChildIndex(target);
				parent.removeChildAt(index);
				parent.addChildAt(newView, index);
			}
		}
		
		public function set view(value:Class):void
		{
			_view = value;
		}
		
		protected var _view:Class = UIComponent;
	}
}