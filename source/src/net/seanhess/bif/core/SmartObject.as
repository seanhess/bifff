package net.seanhess.bif.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.utils.ObjectProxy;
	import flash.utils.flash_proxy;
	import mx.utils.object_proxy;
	
	use namespace flash_proxy;
	use namespace object_proxy;
	
	dynamic public class SmartObject extends ObjectProxy implements ISmartObject, IEventDispatcher
	{
		public function SmartObject(property:String=null, source:Object=null):void
		{
			this.soSource = source;
			this.soProperty = property;
		}
		
		/**
		 * The name of the property to fetch on the parent smart object
		 */
		public var soProperty:String;
		
		/**
		 * All smart objects must point to one of the supported root
		 * types, like target or event. Root ones point to their source
		 * 
		 * So, for property smart objects, the source will be another 
		 * smart object
		 */
		public var soSource:Object;
		
		/**
		 * when they do something like event.myProperty, we want a smart 
		 * object that has all the information to fetch that property
		 */
		override flash_proxy function getProperty(name:*):* 
		{
			var child:SmartObject = new SmartObject(name, this);
        	return child;
	    }
	    
	    /**
	    * If it is a smart object, resolve the parent, and fetch
	    * the property on the resolution.
	    * 
	    * If anything else, just get the property on it
	    */
	    public function resolve(scope:Scope):Object
	    {
	    	var result:Object;
	    	
	    	if (soSource && soSource is ISmartObject)
	    		result = this.soSource.resolve(scope)[this.soProperty];

			else
				result = scope[this.soProperty];
				
			return result;
	    }
	}
}