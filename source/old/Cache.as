package net.seanhess.bifff.behaviors
{
	import net.seanhess.bifff.core.IResolver;
	import net.seanhess.bifff.core.Resolver;
	import net.seanhess.bifff.scope.IScopeable;
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.scope.SmartObject;
	
	dynamic public class Cache extends SmartObject implements IBehavior, IScopeable
	{
		public var resolver:IResolver = new Resolver();		
		public var scope:Scope = new Scope();

		protected var _value:*;

		public function set target(value:*):void
		{
			scope.target = value;
		}
		
		public function set parent(value:Scope):void
		{
			scope.parent = value;	
		}
		
		public function set value(value:*):void
		{
			_value = value;
		}
		
		public function get value():*
		{
			return this.resolve(null);
		}
		
		override public function resolve(scope:Scope):Object
		{
			return resolver.resolveObject(_value, this.scope); // ignore their scope, resolve it with our scope!
		}
	}
}