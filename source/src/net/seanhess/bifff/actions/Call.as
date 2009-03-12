package net.seanhess.bifff.actions
{
	import net.seanhess.bifff.actions.IAction;
	import net.seanhess.bifff.core.IResolver;
	import net.seanhess.bifff.core.Resolver;
	import net.seanhess.bifff.core.Scope;
	
	/**
	 * Calls a method
	 */
	public class Call implements IAction
	{
		public var resolver:IResolver = new Resolver();
		
		public function apply(scope:Scope):void
		{
			var arguments:Array = resolver.resolveArguments(_arguments, scope);
			var method:Function = resolver.resolveObject(_method, scope) as Function;	
			
			method.apply(null, arguments);
		}
		
		public function set arguments(value:Object):void
		{
			if (!(value is Array))
				value = [value];
				 
			_arguments = value as Array;
		}
		
		public function set method(value:Object):void
		{
			_method = value;
		}
		
		protected var _arguments:Array;
		protected var _method:Object;
	}
}