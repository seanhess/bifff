package net.seanhess.bif.core
{
	import flash.utils.Dictionary;
	
	import mx.styles.CSSStyleDeclaration;
	
	public class BifffStyle
	{
		public var styles:Dictionary = new Dictionary(true);
		
		public function set styleName(value:String):void
		{
			var sections:Array = value.split(" ");
			
			removeAllStyles();
			
			for each (var style:String in sections)
				addStyle(style);
		}
		
		public function get styleName():String
		{
			var stylesArray:Array = [];			
			for (var style:String in styles)
				stylesArray.push(style);
				
			return stylesArray.join(" ");
		}
		
		public function matchStyle(style:String):Boolean
		{
			return styles[style];
		}
		
		public function addStyle(style:String):void
		{
			styles[style] = true;
		}
		
		public function removeStyle(style:String):void
		{
			delete styles[style];
		}
		
		public function removeAllStyles():void
		{
			styles = new Dictionary(true);
		}
	}
}