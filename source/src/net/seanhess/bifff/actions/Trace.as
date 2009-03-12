package net.seanhess.bif.actions
{
	import net.seanhess.bif.actions.IAction;
	import net.seanhess.bif.core.IResolver;
	import net.seanhess.bif.core.Resolver;
	import net.seanhess.bif.core.Scope;
	
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