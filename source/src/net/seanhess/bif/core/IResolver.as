package net.seanhess.bif.core
{
	public interface IResolver
	{
		function resolveArguments(arguments:Array, scope:Scope):Array;
		function resolveObject(result:Object, scope:Scope):Object;	
	}
}