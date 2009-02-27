package net.seanhess.bif.behaviors
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * Dispatches an event on the target.
	 */
	public class DispatchEvent implements IBehavior
	{
		public function add(target:*):void
		{
			var arguments:Array = constructorArguments;
			
			if (arguments == null && eventType != null )
				arguments = [eventType];
			
			var event:Event = createInstance(factory, arguments) as Event;
			
			for (var property:String in eventProperties)
				event[property] = eventProperties[property];
				
			(target as IEventDispatcher).dispatchEvent(event);			
		}
		
		public function remove(target:*):void
		{
			// um, doesn't do anything.
		}
		
		/**
		 * The event type. 
		 */
		public function set generator(value:Class):void
		{
			factory = value;
		}
		
		/**
		 * Constructor Arguments - can just pass the first if you want
		 */
		public function set arguments(value:Object):void
		{
			if (!(value is Array))
				value = [value];
				
			constructorArguments = value as Array;
		}
		
		/**
		 * Alias to set the first constructor argument?
		 */
		public function set type(value:String):void
		{
			eventType = value;
		}
		
		/**
		 * A list of properties to set on the event before dispatching
		 */
		public function set properties(value:Object):void
		{
			eventProperties = value;
		}
		
		/**
		 * can't use function.apply because stupid Class doesn't extend Function. Oh well :)
		 */
		public function createInstance(template:Class, p:Array):Object
		{
			var newInstance:Object;
			if(!p || p.length == 0)
			{
				newInstance = new template();
				
			}
			else
			{
				// ugly way to call a constructor. 
				// if someone knows a better way please let me know (nahuel at asfusion dot com).
				switch(p.length)
				{
					case 1:	newInstance = new template(p[0]); break;
					case 2:	newInstance = new template(p[0], p[1]); break;
					case 3:	newInstance = new template(p[0], p[1], p[2]); break;
					case 4:	newInstance = new template(p[0], p[1], p[2], p[3]); break;
					case 5:	newInstance = new template(p[0], p[1], p[2], p[3], p[4]); break;
					case 6:	newInstance = new template(p[0], p[1], p[2], p[3], p[4], p[5]); break;
					case 7:	newInstance = new template(p[0], p[1], p[2], p[3], p[4], p[5], p[6]); break;
					case 8:	newInstance = new template(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]); break;
					case 9:	newInstance = new template(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]); break;
					case 10:newInstance = new template(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9]); break;
				}
			}
			return newInstance;
		}
		
		protected var factory:Class = Event;
		protected var constructorArguments:Array;
		protected var eventProperties:Object;
		protected var eventType:String;
	}
}