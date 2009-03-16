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
		protected var target:UIComponent;
		
		public function MultiStyleDeclaration(styleNames:String=null, target:UIComponent=null):void
		{
			if (styleNames)
				this.styleNames = styleNames;
				
			this.target = target;
		}
		
		override mx_internal function addStyleToProtoChain(chain:Object,
                                         target:DisplayObject,
                                         filterMap:Object = null):Object
		{
			// find all the css declarations and call them all!
			
			this.target = target as UIComponent;
			
			for each (var declaration:CSSStyleDeclaration in styleMap)
				if (declaration)
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
			
			setting = true;
			
			for each (var style:String in newStyles)
				addStyle(style);	

			setting = false;
				
			invalidate();	
		}
		
		/**
		 * Add a styleName
		 */
		public function addStyle(name:String):void
		{
			styleMap[name] = StyleManager.getStyleDeclaration("." + name);
			invalidate();
		}
		
		public function removeStyle(name:String):void
		{
			delete styleMap[name];
			invalidate();
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
		
		protected function invalidate():void
		{
			invalid = true;
		}
		
		public function forceUpdate():void
		{
			if (setting == false && this.target)
			{
				this.target.styleName = this.clone(); // regenerate! // I only want to do this  												
				this.target.dispatchEvent(new Event(BehaviorMap.STYLES_CHANGED, true)); 	// it will be picked up by the map again
			}
		}
		
		/**
		 * toString will cause it to work with any functionality that 
		 * currently checks the style name to work. 
		 */
		override public function toString():String
		{
			return styles.join(" ");
		}
		
		public function clone():MultiStyleDeclaration
		{
			var declaration:MultiStyleDeclaration = new MultiStyleDeclaration();
				declaration.styleMap = this.styleMap;
				
			return declaration;
		}
		
		public var styleMap:Dictionary = new Dictionary(true);
		protected var invalid:Boolean = true;
		protected var _stylesList:Array;
		protected var setting:Boolean = false;
	}
}