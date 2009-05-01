package net.seanhess.bifff.behaviors
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
	
	import net.seanhess.bifff.utils.Invalidator;
	import net.seanhess.bifff.utils.Targets;
	
	/**
	 * Allows you to set properties and styles on the target.
	 * 
	 * If you update them afterward, they will forward the new
	 * values to all the targets. 
	 */
	dynamic public class Set extends Proxy
	{
		protected var values:Object = {};
		protected var updates:Object = {};
		protected var targets:Targets = new Targets();
		protected var invalidator:Invalidator = new Invalidator(commit);
		
		public function set target(value:*):void
		{
			targets.add(value);
			apply(value);
		}
		
		public function apply(target:*):void
		{
			for (var property:String in values)
			{
				var value:* = values[property];
				setValueOnTarget(target, property, value);
			}
		}
		
		protected function setValueOnTarget(target:*, property:String, value:*):void
		{
			try 
			{
				setPropertyOnTarget(target, property, value);
			}
			catch (e:Error)
			{
				setStyleOnTarget(target, property, value);
			}
		}
		
		protected function setPropertyOnTarget(target:*, property:String, value:*):void
		{
			target[property] = value;
		}
		
		protected function setStyleOnTarget(target:*, property:String, value:*):void
		{
			if (target is IStyleClient)
			{
				var styleClient:IStyleClient = target as IStyleClient;
				styleClient.setStyle(property, value);
			}
		}
		
		/**
		 * Specify a styleName to pull property updates from. This should
		 * be specified in a flex sylesheet like normal. 
		 */
		public function set style(value:String):void
		{
			var declaration:CSSStyleDeclaration = StyleManager.getStyleDeclaration("." + value);
			declaration.factory.prototype = {};
			
			var properties:Object = new declaration.factory;

			for (var property:String in properties)
				this[property] = properties[property];
		}
		
		/**
		 * Stores the values, and marks them for updates
		 */
		override flash_proxy function setProperty(name:*, value:*):void {
	        values[name] = value;
	        updates[name] = true;
	        invalidator.invalidate("updates");
	    }
	    
	    protected function commit():void
	    {
	    	if (invalidator.invalid("updates"))
	    		targets.eachTarget(runUpdatesOnTarget);
	    }
	    
	    public function runUpdatesOnTarget(target:*):void
	    {
    		for (var property:String in updates)
				setValueOnTarget(target, property, values[property]);
	    }
	}
}