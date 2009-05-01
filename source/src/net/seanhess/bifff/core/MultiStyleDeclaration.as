package net.seanhess.bifff.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	use namespace mx_internal;
	
	/**
	 * these serve to wrap several CSSStyleDeclarations into one, and to manage
	 * updates to the style at runtime. 
	 * 
	 * Note that these are different from normal CSSStyleDeclarations, which 
	 * are one per style in the stylesheet. These are one per component. It keeps 
	 * track of its component so it can manage updates after something changes to it.
	 */
	public class MultiStyleDeclaration extends CSSStyleDeclaration
	{
		public var targets:Dictionary = new Dictionary(true);
		
		public function MultiStyleDeclaration(styleNames:String=null, target:UIComponent=null):void
		{
			if (styleNames)
				this.styleNames = styleNames;
				
			if (target)
				targets[target] = true;
		}
		
		override mx_internal function addStyleToProtoChain(chain:Object,
                                         target:DisplayObject,
                                         filterMap:Object = null):Object
		{
			// find all the css declarations and call them all!
			
			targets[target] = true;
			
			for (var name:String in styles)
			{
				var declaration:CSSStyleDeclaration = declarations[name];
				
				if (declaration)
					chain = declaration.addStyleToProtoChain(chain, target, filterMap);
			}
				
			return chain;
		}
		
		/**
		 * Allows you to set by multi-style string
		 */
		public function set styleNames(value:String):void
		{
			declarations = new Dictionary(true);
			styles = new Dictionary(true);
			
			var newStyles:Array = (value) ? value.split(/\s+/) : [];
			
			for each (var style:String in newStyles)
				addStyle(style);	
		}
		
		public function get styleNames():String
		{
			return this.toString();
		}
		
		/**
		 * Add a styleName
		 */
		public function addStyle(name:String):void
		{
			styles[name] = true;
			declarations[name] = StyleManager.getStyleDeclaration("." + name);
		}
		
		public function removeStyle(name:String):void
		{
			delete styles[name];
			delete declarations[name];
		}
		
		public function hasStyle(name:String):Boolean
		{
			return (styles[name] != null);
		}
		
		public function forceUpdate():void
		{
			var clone:MultiStyleDeclaration = this.clone();
			
			for (var target:Object in targets)
			{
				target.styleName = clone;											
				target.dispatchEvent(new Event(BehaviorMap.STYLES_CHANGED, true)); 	// it will be picked up by the map again
			}
		}
		
		/**
		 * toString will cause it to work with any functionality that 
		 * currently checks the style name to work. 
		 */
		override public function toString():String
		{
			return toArray().join(" ");
		}
		
		public function toArray():Array
		{
			var styleNames:Array = [];
			for (var name:String in styles)
			{
				styleNames.push(name);
			}
			
			return styleNames;
		}
		
		public function clone():MultiStyleDeclaration
		{
			var declaration:MultiStyleDeclaration = new MultiStyleDeclaration();
				declaration.styles = this.styles;
				declaration.declarations = this.declarations;
				declaration.targets = this.targets;
				
			return declaration;
		}
		
		public var styles:Dictionary = new Dictionary(true);
		public var declarations:Dictionary = new Dictionary(true); // maps names to declarations
	}
}