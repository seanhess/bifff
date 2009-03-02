package net.seanhess.bif.behaviors
{
	import net.seanhess.bif.core.IScope;
	
	public interface IBehavior
	{
		function apply(scope:IScope):void;
	}
}