package net.seanhess.bif.core
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	[Bindable]
	dynamic public class SmartObject extends Proxy implements ISmartObject
	{
		public static const TARGET:String = "target";
		public static const EVENT:String = "event";
		public static const PROPERTY:String = "property";
		
		public function SmartObject(type:String=null, source:Object=null, property:String=null):void
		{
			this.type = type;
			this.source = source;
			this.property = property;
		}
		
		/**
		 * The type of obj
		 */
		public var type:String;
		
		/**
		 * The name of the property to fetch on the parent smart object
		 */
		public var property:String;
		
		/**
		 * All smart objects must point to one of the supported root
		 * types, like target or event. Root ones point to their source
		 * 
		 * So, for property smart objects, the source will be another 
		 * smart object
		 */
		public var source:Object;
		
		/**
		 * when they do something like event.myProperty, we want a smart 
		 * object that has all the information to fetch that property
		 */
		override flash_proxy function getProperty(name:*):* 
		{
			var child:SmartObject = new SmartObject(PROPERTY, this, name);
        	return child;
	    }
	    
	    public function resolve(scope:IScope):Object
	    {
			switch(this.type)
			{
				case SmartObject.EVENT:	
					return scope.event;
				
				case SmartObject.TARGET:
					return scope.target;
					
				case SmartObject.PROPERTY:
					return this.source.resolve(scope)[this.property];
			}	
			
			return null;
	    }
	}
}