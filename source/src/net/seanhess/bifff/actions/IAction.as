package net.seanhess.bif.actions
{
	/**
	 * Actions are tags that can go inside of <selectors>.
	 * 
	 * They apply behaviors to matched targets
	 */
	public interface IAction
	{
		function apply(scope:Scope):void;
	}
}