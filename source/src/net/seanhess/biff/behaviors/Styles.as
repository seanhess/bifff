package net.seanhess.biff.behaviors
{
	import flash.utils.Dictionary;
	
	import mx.core.UIComponent;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
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
		protected var views:Dictionary = new Dictionary(true);
		protected var classesToAdd:Array = [];
		protected var classesToRemove:Array = [];
		
		public function add(target:*):void
		{
			views[target] = true;
			
			for each (var style:String in classesToAdd)
			{
				updateStyleDeclaration(target, style);
			}
		}
		
		public function remove(target:*):void
		{
			delete views[target];
			
			for each (var style:String in classesToRemove)
			{
				// FIXME
			}
		}
		
		public function updateStyleDeclaration(target:*, styleName:String):void
		{
			var component:UIComponent = target as UIComponent;
			var declaration:CSSStyleDeclaration = StyleManager.getStyleDeclaration("." + styleName);
			
			var oldStyleName:String = component.styleName as String;
			
			component.styleName = declaration;
		}
		
		public function set addClass(value:Object):void
		{
			if (value is String)
				value = [value];
				
			classesToAdd = value as Array;
		}
		
		public function set removeClass(value:Object):void
		{
			if (value is String)
				value = [value];
				
			classesToRemove = value as Array;
		}
		
	}
}