package net.seanhess.bifff.actions
{
	import net.seanhess.bifff.core.IResolver;
	import net.seanhess.bifff.core.Resolver;
	import net.seanhess.bifff.scope.Scope;
	
	public class Trace implements IAction
	{
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
		
		public function apply(scope:Scope):void
		{
			trace(resolver.resolveObject(message, scope));
		}
	}
}