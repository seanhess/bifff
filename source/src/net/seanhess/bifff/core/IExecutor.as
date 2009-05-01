package net.seanhess.bifff.core
{
	import flash.events.IEventDispatcher;
	
	public interface IExecutor extends IEventDispatcher
	{
		function executeSelector(target:*, selector:ISelector):void;
		function executeActions(target:*, actions:Array, scope:Scope):void;
	}
}