package net.seanhess.bif.behaviors
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import net.seanhess.bif.utils.Invalidator;
	
	import mx.styles.IStyleClient;
	
	/**
	 * Sets styles (setStyle) and properties. 
	 * 
	 * Can be used for setter-based Dependency Injection
	 * 
	 * If the property is updated on the setter, it will update all the views  
	 */
	dynamic public class Set extends Proxy implements IBehavior
	{
		protected var views:Dictionary = new Dictionary(true);
		protected var values:Object = {};
		protected var updates:Object = {};
		protected var invalidator:Invalidator = new Invalidator(commit);
		
		public function apply(target:*):void
		{
			var old:Object = {};
			
			for (var property:String in values)
				updateProperty(target, property, values[property], old);
			
			views[target] = old;
		}
		
		public function undo(target:*):void
		{
			var old:Object = views[target];
			
			for (var property:String in old)
				updateProperty(target, property, old[property]); 
			
			delete views[target];
		}
		
		protected function updateProperty(target:*, property:String, value:*, old:Object=null):void
		{
			old = old || {};
			
			try {
				old[property] = target[property];
				target[property] = value;
			}
			catch (e:Error)
			{
				if (target is IStyleClient)
				{
					var styleClient:IStyleClient = target as IStyleClient;
						
					old[property] = styleClient.getStyle(property);
					styleClient.setStyle(property, value);
				}
				else
					throw new Error("Could not set property " + property + " on " + target);
			}
		}
		
		override flash_proxy function setProperty(name:*, value:*):void {
	        values[name] = value;
	        updates[name] = true;
	        invalidator.invalidate("updates");
	    }
	    
	    protected function commit():void
	    {
	    	if (invalidator.invalid("updates"))
	    	{
	    		for (var target:* in views)
	    		{
	    			for (var property:String in updates)
	    			{
	    				updateProperty(target, property, values[property], views[target]);
	    			}
	    		}
	    	}
	    }
	}
}