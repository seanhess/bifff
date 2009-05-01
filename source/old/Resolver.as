package net.seanhess.bifff.core
{
	import net.seanhess.bifff.scope.ISmartObject;
	import net.seanhess.bifff.scope.Scope;
	
	public class Resolver implements IResolver
	{
		public function resolveArguments(arguments:Array, scope:Scope):Array
		{
			var resolved:Array = [];
			
			for each (var argument:Object in arguments)
			{
				resolved.push(resolveObject(argument, scope));
			}
			
			return resolved;
		}
		
		public function resolveObject(result:Object, scope:Scope):Object
		{
			if (result is ISmartObject)
				result = result.resolve(scope); 
			
			return result;
		}

	}
}