package net.seanhess.bif.core
{
	import flash.events.IEventDispatcher;
	
	public interface IExecutor extends IEventDispatcher
	{
		function executeSelector(target:*, selector:ISelector):void;
		function executeBehaviors(target:*, behaviors:Array, scope:Scope=null):void;
		function executeMatches(matches:Array, behaviors:Array):void;
	}
}