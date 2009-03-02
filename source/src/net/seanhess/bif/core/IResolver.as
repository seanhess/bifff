package net.seanhess.bif.core
{
	public interface IResolver
	{
		function resolveArguments(arguments:Array, scope:IScope):Array;
		function resolveObject(result:Object, scope:IScope):Object;	
	}
}