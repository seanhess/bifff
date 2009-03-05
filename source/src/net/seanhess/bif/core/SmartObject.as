package net.seanhess.bif.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	dynamic public class SmartObject extends Proxy implements ISmartObject, IEventDispatcher
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
	    
	    
	    
	    
	    
	    
	    /*-----------------------------------------------------------------------------------------------------------
		*  Implementation of IEventDispatcher interface  -- copied from mate - trying to get rid of binding warnings
		-------------------------------------------------------------------------------------------------------------*/
		private var dispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
		/**
		 * Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event. 
		 * You can register event listeners on all nodes in the display list for a specific type of event, phase, and priority.
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, weakRef:Boolean = false):void
	    {
	        dispatcher.addEventListener(type, listener, useCapture, priority, weakRef);
	    }
	    
		/**
		 * Dispatches an event into the event flow. The event target is the EventDispatcher object upon which dispatchEvent() is called.
		 */
	    public function dispatchEvent(event:flash.events.Event):Boolean
	    {
	        return dispatcher.dispatchEvent(event);
	    }
	    
		/**
		 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event. 
		 * This allows you to determine where an EventDispatcher object has altered handling of an event type
		 * in the event flow hierarchy. To determine whether a specific event type will actually trigger an
		 * event listener, use <code>IEventDispatcher.willTrigger()</code>.
		 * 
		 * <p>The difference between <code>hasEventListener()</code> and <code>willTrigger()</code> is that <code>hasEventListener()</code>
		 * examines only the object to which it belongs, whereas <code>willTrigger()</code> examines the entire event
		 * flow for the event specified by the type parameter.</p>
		 */
	    public function hasEventListener(type:String):Boolean
	    {
	        return dispatcher.hasEventListener(type);
	    }
	    
		/**
		 * Removes a listener from the EventDispatcher object. If there is no matching listener registered with 
		 * the EventDispatcher object, a call to this method has no effect.
		 */
	    public function removeEventListener(type:String,
	                                        listener:Function,
	                                        useCapture:Boolean = false):void
	    {
	        dispatcher.removeEventListener(type, listener, useCapture);
	    }
	    
		/**
		 * Checks whether an event listener is registered with this EventDispatcher object
		 * or any of its ancestors for the specified event type. This method returns true
		 * if an event listener is triggered during any phase of the event flow when an 
		 * event of the specified type is dispatched to this EventDispatcher object or any of its descendants.
		 * 
		 * <p>The difference between <code>hasEventListener()</code> and <code>willTrigger()</code> is that <code>hasEventListener()</code>
		 * examines only the object to which it belongs, whereas <code>willTrigger()</code> examines the entire event
		 * flow for the event specified by the type parameter.</p>
		 */
	    public function willTrigger(type:String):Boolean
	    {
	        return dispatcher.willTrigger(type);
	    }
	}
}