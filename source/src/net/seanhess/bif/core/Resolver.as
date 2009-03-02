package net.seanhess.bif.core
{
	public class Resolver implements IResolver
	{
		public function resolveArguments(arguments:Array, scope:IScope):Array
		{
			var resolved:Array = [];
			
			for each (var argument:Object in arguments)
			{
				resolved.push(resolveObject(argument, scope));
			}
			
			return resolved;
		}
		
		public function resolveObject(result:Object, scope:IScope):Object
		{
			if (result is SmartObject)
				result = result.resolve(scope); 
			
			return result;
		}

	}
}