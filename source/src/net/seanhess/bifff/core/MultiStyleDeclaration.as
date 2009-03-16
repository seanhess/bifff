package net.seanhess.bifff.core
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	import mx.core.mx_internal;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	use namespace mx_internal;
	
	public class MultiStyleDeclaration extends CSSStyleDeclaration
	{
		public function MultiStyleDeclaration(styleNames:String=null):void
		{
			if (styleNames)
				this.styleNames = styleNames;
		}
		
		override mx_internal function addStyleToProtoChain(chain:Object,
                                         target:DisplayObject,
                                         filterMap:Object = null):Object
		{
			// find all the css declarations and call them all!
			
			for each (var declaration:CSSStyleDeclaration in styleMap)
				chain = declaration.addStyleToProtoChain(chain, target, filterMap);
				
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
		
		/**
		 * Add a styleName
		 */
		public function addStyle(name:String):void
		{
			styleMap[name] = StyleManager.getStyleDeclaration("." + name);
			invalid = true;
		}
		
		public function removeStyle(name:String):void
		{
			delete styleMap[name];
			invalid = true;
		}
		
		public function hasStyle(name:String):Boolean
		{
			return styleMap[name];
		}
		
		public function get styles():Array
		{
			if (invalid)
			{
				var styleNames:Array = [];
			
				for (var style:String in styleMap)
					styleNames.push(style);
					
				_stylesList = styleNames;
				invalid = false;
			}
			
			return _stylesList;
		}
		
		/**
		 * toString will cause it to work with any functionality that 
		 * currently checks the style name to work. 
		 */
		override public function toString():String
		{
			return styles.join(" ");
		}
		
		protected var styleMap:Dictionary = new Dictionary(true);
		protected var invalid:Boolean = true;
		protected var _stylesList:Array;
	}
}