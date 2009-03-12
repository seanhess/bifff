package net.seanhess.bifff.core
{
	import net.seanhess.bifff.scope.Scope;
	
	public interface IResolver
	{
		function resolveArguments(arguments:Array, scope:Scope):Array;
		function resolveObject(result:Object, scope:Scope):Object;	
	}
}