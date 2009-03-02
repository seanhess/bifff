package net.seanhess.bif.behaviors
{
	import net.seanhess.bif.core.IResolver;
	import net.seanhess.bif.core.IScope;
	import net.seanhess.bif.core.Resolver;
	
	/**
	 * Calls a method
	 */
	public class Call implements IBehavior
	{
		public var resolver:IResolver = new Resolver();
		
		public function apply(scope:IScope):void
		{
			var arguments:Array = resolver.resolveArguments(_arguments, scope);
			var method:Function = resolver.resolveObject(_method, scope) as Function;	
			
			method.apply(null, arguments);
		}
		
		public function set arguments(value:Object):void
		{
			if (!value is Array)
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