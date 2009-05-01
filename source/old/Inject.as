package net.seanhess.bifff.behaviors
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import net.seanhess.bifff.core.IResolver;
	import net.seanhess.bifff.core.Resolver;
	import net.seanhess.bifff.scope.IScopeable;
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.utils.Invalidator;
	import net.seanhess.bifff.utils.TargetRegistry;
	
	/**
	 * Sets only properties. Throws a runtime error if they don't exist
	 * 
	 * Use Set if you want to set properties OR styles
	 * 
	 * Can be used for setter-based Dependency Injection
	 * 
	 * If the property is updated on the setter, it will update all the views  
	 */
	dynamic public class Inject extends Proxy implements IBehavior, IScopeable
	{
		protected var values:Object = {};
		protected var updates:Object = {};
		protected var invalidator:Invalidator = new Invalidator(commit);
		protected var resolver:IResolver = new Resolver();
		protected var scope:Scope = new Scope();
		
		protected var _redirect:Array;
		
		public var registry:TargetRegistry = new TargetRegistry(apply);
		
		/**
		 * Let's see, whenever the target changes, apply yourself to it!
		 * 
		 * This is supposed to work for multiple targets?
		 */
		public function set target(value:*):void
		{
			scope.target = value;
			
			if (_redirect)	value = _redirect;
			
			registry.applyTargets(value);
		}
		
		public function apply(target:*):void
		{
			for (var property:String in values)
			{
				var value:* = resolver.resolveObject(values[property], scope);
				updateProperty(target, property, value);
			}
		}
		
		public function set parent(value:Scope):void
		{
			scope.parent = value;
		}
		
		/**
		 * The targets to set the stuff on
		 */
		public function set redirect(value:*):void
		{
			if (!(value is Array))
				value = [value];
			
			_redirect = value as Array;
		}

		protected function updateProperty(target:*, property:String, value:*):Boolean
		{
			try 
			{
				target[property] = value;
				return true;
			}
			catch (e:Error)
			{
				failInject(target, property, value);	
			}

			return false;
		}
		
		protected function failInject(target:*, property:String, value:*):void
		{
			throw new Error("Could not set property: '" + property + "' on target: '" + target + "' to value: '" + value  +"'");
		}
		
		override flash_proxy function setProperty(name:*, value:*):void {
	        values[name] = value;
	        updates[name] = true;
	        invalidator.invalidate("updates");
	    }
	    
	    /**
	    * Updates are not resolved.
	    */
	    protected function commit():void
	    {
	    	if (invalidator.invalid("updates"))
	    		for (var target:* in registry.map)
	    			for (var property:String in updates)
	    				updateProperty(target, property, values[property]);
	    }
	}
}