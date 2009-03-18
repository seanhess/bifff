package net.seanhess.bifff.scope
{
	import flash.events.IEventDispatcher;
	import flash.utils.flash_proxy;
	
	import mx.core.IMXMLObject;
	import mx.utils.ObjectProxy;
	import mx.utils.object_proxy;
	
	use namespace flash_proxy;
	use namespace object_proxy;
	
	dynamic public class SmartObject extends ObjectProxy implements ISmartObject, IEventDispatcher, IMXMLObject
	{	
		public function SmartObject(property:String=null, source:Object=null):void
		{
			this.source = source;
			this.property = property;
		}
		
		public function initialized(document:Object, id:String):void
		{
			this.property = id;
		}
		
		/**
		 * The name of the property to fetch on the parent smart object
		 */
		public function set property(value:String):void
		{
			_property = value;
		}
		
		/**
		 * All smart objects must point to one of the supported root
		 * types, like target or event. Root ones point to their source
		 * 
		 * So, for property smart objects, the source will be another 
		 * smart object
		 */
		public function set source(value:Object):void
		{
			_source = value;
		}
		
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
	    	
	    	if (_source && _source is ISmartObject)
	    		result = _source.resolve(scope)[_property];

			else if (scope[_property] == null && scope.parent)
				result = resolve(scope.parent);
			
			else
				result = scope[_property];
				
			return result;
	    }
	    
	    protected var _property:String;
	    protected var _source:Object;
	}
}