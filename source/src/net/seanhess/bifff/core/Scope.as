package net.seanhess.bifff.core
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	[Bindable]
	dynamic public class Scope extends Proxy
	{
		public static var current:Scope;
		
		public var parent:Scope;
		public var values:Object;
		
		public function Scope(properties:Object=null)
		{
			values = {};
			
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
			
			if (value == null && parent)
				value = parent[name]; 
				
			return value;
	    }
	    
	    override flash_proxy function setProperty(name:*, value:*):void 
		{
			values[name] = value;
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