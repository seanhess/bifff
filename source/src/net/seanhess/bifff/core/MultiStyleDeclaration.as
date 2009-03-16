package net.seanhess.bifff.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
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
			
			for each (var name:String in styles)
			{
				var declaration:CSSStyleDeclaration = styleMap[name];
				
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
			styleMap = new Dictionary(true);
			
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
			styles.addItem(name);
			styleMap[name] = StyleManager.getStyleDeclaration("." + name);
		}
		
		public function removeStyle(name:String):void
		{
			if (styles.contains(name))
				styles.removeItemAt(styles.getItemIndex(name));
				
			delete styleMap[name];
		}
		
		public function hasStyle(name:String):Boolean
		{
			return styles.contains(name);
		}
		
		public function forceUpdate():void
		{
			if (setting == false)
			{
				var clone:MultiStyleDeclaration = this.clone();
				
				for (var target:Object in targets)
				{
					target.styleName = clone;											
					target.dispatchEvent(new Event(BehaviorMap.STYLES_CHANGED, true)); 	// it will be picked up by the map again
				}
			}
		}
		
		/**
		 * toString will cause it to work with any functionality that 
		 * currently checks the style name to work. 
		 */
		override public function toString():String
		{
			return styles.source.join(" ");
		}
		
		public function clone():MultiStyleDeclaration
		{
			var declaration:MultiStyleDeclaration = new MultiStyleDeclaration();
				declaration.styles = this.styles;
				declaration.styleMap = this.styleMap;
				declaration.targets = this.targets;
				
			return declaration;
		}
		
		public var styles:ArrayCollection = new ArrayCollection();
		public var styleMap:Dictionary = new Dictionary(true); // maps names to declarations
		
		protected var invalid:Boolean = true;
		protected var setting:Boolean = false;
	}
}