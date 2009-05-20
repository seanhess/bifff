package net.seanhess.bifff.core
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	[Bindable]
	dynamic public class Scope extends Proxy
	{
		public static var current:Scope = new Scope();
		
		public var parent:Scope;
		public var values:Object;
		public var definedValues:Object;
		
		public function Scope(properties:Object=null)
		{
			values = {};
			definedValues = {};
			
			if (properties)
				copy(properties);
		}
		
		public function clone():Scope
		{
			var newScope:Scope = new Scope();
			
			newScope.copy(values);
				
			return newScope;
		}

		override flash_proxy function getProperty(name:*):* 
		{			
			var value:* = values[name];
			
			if (!defined(name))
				throw new Error("Could not find '" + name + "' in scope");
			
			if (!definedLocally(name) && parent)
				value = parent[name]; 
				
			return value;
	    }
	    
	    override flash_proxy function setProperty(name:*, value:*):void 
		{
			definedValues[name] = true;
			values[name] = value;
	    }
	    
	    public function defined(name:*):Boolean
	    {
	    	var isDefined:Boolean = definedLocally(name);
	    	
	    	if (parent && isDefined == false)
	    		isDefined = parent.defined(name);

	    	return isDefined;
	    }
	    
	    public function definedLocally(name:*):Boolean
	    {
	    	return definedValues[name] == true;
	    }
	    
	    public function get current():Scope
	    {
	    	return Scope.current;
	    }
		
		/**
		 * Copies the stuff from the scope asdf
		 * passed in into yourself.
		 */
		public function copy(scope:Object):void
		{
			for (var property:String in scope)
				this[property] = scope[property];
		}
	}
}