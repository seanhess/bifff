package net.seanhess.bifff.behaviors
{
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
	
	/**
	 * Just like inject, but doesn't throw an error if it can't 
	 * be set, and tries to set a style if setting the property
	 * fails. 
	 */
	dynamic public class Set extends Inject
	{
		override protected function updateProperty(target:*, property:String, value:*):Boolean
		{
			var success:Boolean = super.updateProperty(target, property, value);
			
			if (!success && target is IStyleClient)
			{
				var styleClient:IStyleClient = target as IStyleClient;
				styleClient.setStyle(property, value);
			}
			
			return true;
		}
		
		override protected function failInject(target:*, property:String, value:*):void
		{
			// do nothing // 
		}
		
		/**
		 * A stylename to copy properties from. Just pulls them like normal!
		 */
		public function set style(value:String):void
		{
			var declaration:CSSStyleDeclaration = StyleManager.getStyleDeclaration("." + value);
			declaration.factory.prototype = {};
			
			var properties:Object = new declaration.factory;

			for (var property:String in properties)
				this[property] = properties[property];
		}
	}
}