package net.seanhess.bif.behaviors
{
	import flash.events.Event;
	
	import net.seanhess.bif.core.BehaviorMap;
	import net.seanhess.bif.core.Scope;
	import net.seanhess.bif.core.StyleMerger;
	
	/**
	 * Allows you to set the style of the target. For now, this is a total hack, because it replaces the styleName, which 
	 * is what we're using to get classnames. It would be nice if I could use another property instead of styleName
	 * because then I could set this with impunity, but I still wouldn't be able to add multiple. I'm hoping to figure
	 * out how to do with StyleManager, UIComponent and CSSStyleDeclaration. 
	 * 
	 * At worst, I can subclass CSSStyleDeclaration, have it remember the old styleNames, and merge all the styles together, 
	 * but that sounds like a lot of work.
	 * 
	 * FIXME: Support multiple styles somehow? 
	 * 
	 * FIXME: Use another method to add the style. There has got to be something with StyleManager - a way to manually
	 * apply a CSSStyleDeclaration or something. 
	 * 
	 * TODO: Support remove (after multiple is working
	 */
	public class Styles implements IBehavior
	{
		protected var classesToAdd:Array = [];
		protected var classesToRemove:Array = [];
		public var merger:StyleMerger = new StyleMerger();
		
		public function apply(scope:Scope):void
		{
//			var declaration:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".test");
//				scope.target.styleName = declaration;
			
			for each (var add:String in classesToAdd)
			{
				merger.addClass(scope.target, add);
			}
			
			for each (var remove:String in classesToRemove)
			{
				merger.removeClass(scope.target, remove);
			}
			
			// Get it to reinitialize // 
			scope.target.dispatchEvent(new Event(BehaviorMap.STYLES_CHANGED, true));
		}
		
		public function set addClass(value:Object):void
		{
			if (value is String)
				value = [value];
				
			classesToAdd = value as Array;
		}
		
		/**
		 * TODO: Add support for undoing behaviors, otherwise, this won't do anything.
		 * 
		 * Well, it will work so long as another styleName is undoing it
		 */
		public function set removeClass(value:Object):void
		{
			if (value is String)
				value = [value];
				
			classesToRemove = value as Array;
		}
		
	}
}