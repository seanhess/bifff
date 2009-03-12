package net.seanhess.bifff.actions
{
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
	
	import net.seanhess.bifff.actions.IAction;
	import net.seanhess.bifff.core.IResolver;
	import net.seanhess.bifff.core.Resolver;
	import net.seanhess.bifff.core.Scope;
	import net.seanhess.bifff.utils.Invalidator;
	
	/**
	 * Sets styles (setStyle) and properties. 
	 * 
	 * Can be used for setter-based Dependency Injection
	 * 
	 * If the property is updated on the setter, it will update all the views  
	 */
	dynamic public class Set extends Proxy implements IAction
	{
		protected var views:Dictionary = new Dictionary(true);
		protected var values:Object = {};
		protected var updates:Object = {};
		protected var invalidator:Invalidator = new Invalidator(commit);
		protected var resolver:IResolver = new Resolver();
		
		public function apply(scope:Scope):void
		{
			var old:Object = {};
			
			var target:* = target || scope.target;
			
			for (var property:String in values)
			{
				var value:* = resolver.resolveObject(values[property], scope);
				updateProperty(target, property, value, old);
			}
			
			views[target] = old;
		}
		
		public function undo(scope:Scope):void
		{
			var old:Object = views[scope.target];
			
			for (var property:String in old)
				updateProperty(scope.target, property, old[property]); 
			
			delete views[scope.target];
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
		
		protected function updateProperty(target:*, property:String, value:*, old:Object=null):void
		{
			old = old || {};
			
			try {
				target[property] = value;
				
				try {
					old[property] = target[property];
				} catch(e:Error) {}
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
				{
					trace("Bifff: Silent Fail - Could not set property " + property + " on " + target); 
//					throw new Error("Could not set property " + property + " on " + target);
					
				}
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
	    
	    /**
	    * If you specify a target, it will set the values on the target you specify
	    * only when apply is called. If you want to set to something in particular right
	    * away, use the Apply tag. 
	    */
	    public function set target(value:*):void
	    {
	    	_target = value;
	    }
	    
	    public function get target():*
	    {
	    	return _target;
	    }
	    
	    protected var _target:*;
	}
}