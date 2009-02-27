package net.seanhess.bif.behaviors
{
	import flash.display.DisplayObjectContainer;
	
	import mx.core.Container;
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	
	/**
	 * Swaps you out with another view
	 */
	public class Swap implements IBehavior
	{
		public function apply(target:*):void
		{
			if (!_view)	throw new Error("View was not set");
			
			var newView:* = new _view();
			
			if (target is IDataRenderer && newView is IDataRenderer)
				newView.data = target.data; 
			
			if (target is Container && newView is Container)
			{
				var container:Container = target as Container;
				var children:Array = container.getChildren();
				container.removeAllChildren();
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