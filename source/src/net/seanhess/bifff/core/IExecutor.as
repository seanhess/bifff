package net.seanhess.bifff.core
{
	import flash.events.IEventDispatcher;
	
	import net.seanhess.bifff.scope.Scope;
	
	public interface IExecutor extends IEventDispatcher
	{
		function executeSelector(target:*, selector:ISelector):void;
		function executeActions(target:*, actions:Array):void;
		function executeMatches(matches:Array, actions:Array):void;
	}
}