package net.seanhess.bifff.behaviors
{
	import net.seanhess.bifff.core.IResolver;
	import net.seanhess.bifff.core.Resolver;
	import net.seanhess.bifff.scope.IScopeable;
	import net.seanhess.bifff.scope.Scope;
	
	public class Trace implements IBehavior, IScopeable
	{
		private var scope:Scope = new Scope();
		
		public var resolver:IResolver = new Resolver();
		
		public function set message(value:Object):void
		{
			_message = value;
		}
		
		public function get message():Object
		{
			return _message;
		}
		
		protected var _message:Object = "trace";
		
		public function set target(target:*):void
		{
			scope.target = target;
			trace(resolver.resolveObject(message, scope));
		}
		
		public function set parent(value:Scope):void
		{
			scope.parent = value;
		}
	}
}