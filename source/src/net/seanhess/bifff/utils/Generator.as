package net.seanhess.bifff.utils
{
	import net.seanhess.bifff.core.IResolver;
	import net.seanhess.bifff.core.Resolver;
	import net.seanhess.bifff.core.Scope;
	
	public class Generator
	{
		public var resolver:IResolver = new Resolver();
		
		public function generate(scope:Scope):*
		{
			var instance:* = createInstance(factory, constructorArguments, scope);
			
			setProperties(instance, scope);
			
			return instance;
		}
		
		protected function setProperties(instance:*, scope:Scope):void
		{
			var properties:Object = this.properties || this;
			
			for (var property:String in properties)
				instance[property] = resolver.resolveObject(properties[property], scope);
		}

		/**
		 * The event type. 
		 */
		public function set factory(value:Class):void
		{
			_factory = value;
		}
		
		public function get factory():Class
		{
			return _factory;
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
		
		public function get arguments():Object
		{
			return constructorArguments;
		}
		
		/**
		 * A list of properties to set on the event before dispatching
		 */
		public function set properties(value:Object):void
		{
			_properties = value;
		}
		
		public function get properties():Object
		{
			return _properties;
		}
		
		/**
		 * can't use function.apply because stupid Class doesn't extend Function. Oh well :)
		 * Thanks to Nahuel again
		 */
		public function createInstance(template:Class, p:Array, scope:Scope):Object
		{
			var newInstance:Object;
			if(!p || p.length == 0)
			{
				newInstance = new template();
				
			}
			else
			{
				p = resolver.resolveArguments(p, scope);
				
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
		
		protected var _factory:Class = Object;
		protected var constructorArguments:Array;
		protected var _properties:Object;
	}
}