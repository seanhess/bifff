package net.seanhess.bif.behaviors
{
	import net.seanhess.bif.core.Scope;
	
	public interface IBehavior
	{
		function apply(scope:Scope):void;
	}
}