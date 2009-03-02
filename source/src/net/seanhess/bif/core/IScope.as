package net.seanhess.bif.core
{
	import flash.events.Event;
	
	public interface IScope
	{
		function get event():Event;
		function get target():*;
		function get map():BehaviorMap;
	}
}