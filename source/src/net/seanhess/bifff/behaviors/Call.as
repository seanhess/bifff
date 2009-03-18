package net.seanhess.bifff.behaviors
{
	import net.seanhess.bifff.behaviors.IBehavior;
	import net.seanhess.bifff.core.IResolver;
	import net.seanhess.bifff.core.Resolver;
	import net.seanhess.bifff.scope.IScopeable;
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.utils.TargetRegistry;
	
	/**
	 * Calls a method
	 */
	public class Call implements IBehavior, IScopeable
	{
		public var resolver:IResolver = new Resolver();
		public var scope:Scope = new Scope();
		public var registry:TargetRegistry = new TargetRegistry(apply);
		
		public function set target(value:*):void
		{
			registry.applyTargets(value);	
		}
		
		public function set parent(value:Scope):void
		{
			scope.parent = value;
		} 
		
		public function apply(target:*):void
		{
			scope.target = target;
			
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