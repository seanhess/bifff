package net.seanhess.bif.behaviors
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import mx.core.Container;
	import mx.core.IDataRenderer;
	
	import net.seanhess.bif.core.IScope;
	import net.seanhess.bif.views.ISwappable;
	
	/**
	 * Swaps you out with another view, copies your children
	 * if both are containers, 
	 * 
	 * It also copies the data property from one to the other
	 * 
	 * It copies your ID, but not your styleName, so make sure
	 * you set the styleName on the replacing one to whatever
	 * you want. 
	 */
	public class Swap implements IBehavior
	{
		public function apply(scope:IScope):void
		{
			var target:* = scope.target;
			if (!_view)	throw new Error("View was not set");
			
			var newView:* = new _view();
			
			if (newView is ISwappable)
				(newView as ISwappable).copyView(target);
			
			else 
				copyRegular(target, newView);
			
			if (target.parent)
			{
				var parent:DisplayObjectContainer = target.parent as DisplayObjectContainer;
				var index:int = parent.getChildIndex(target);
				parent.removeChildAt(index);
				parent.addChildAt(newView, index);
			}
			else
				throw new Error("Could not swap view for " + target);
		}
		
		protected function copyRegular(target:*, newView:*):void
		{
			if (target.hasOwnProperty("id") && newView.hasOwnProperty("id"))
			{
//				newView.styleName = target.styleName; // should merge styles eventually?
				newView.id = target.id;
			}
			
			if (target is IDataRenderer && newView is IDataRenderer)
				newView.data = target.data; 
			
			if (target is Container && newView is Container) // this will not  happen for ISimpleItems
			{
				var children:Array = target.getChildren();
				target.removeAllChildren();
				
				for each (var child:DisplayObject in children)
					newView.addChild(child);
			}
		}
		
		public function set view(value:Class):void
		{
			_view = value;
		}
		
		protected var _view:Class;
	}
}