package net.seanhess.bifff.actions
{
	import net.seanhess.bifff.scope.Scope;
	
	/**
	 * Actions are tags that can go inside of <selectors>.
	 * 
	 * They apply actions to matched targets
	 */
	public interface IAction
	{
//		function apply(scope:Scope):void;
		function set parent(value:Scope):void; // the parent scope
	}
}