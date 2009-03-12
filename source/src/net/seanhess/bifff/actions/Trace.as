package net.seanhess.bifff.actions
{
	import net.seanhess.bifff.core.IResolver;
	import net.seanhess.bifff.core.Resolver;
	import net.seanhess.bifff.scope.Scope;
	
	public class Trace implements IAction
	{
		public var message:Object = "trace";
		public var resolver:IResolver = new Resolver();
		
		public function apply(scope:Scope):void
		{
			trace(resolver.resolveObject(message, scope));
		}
	}
}