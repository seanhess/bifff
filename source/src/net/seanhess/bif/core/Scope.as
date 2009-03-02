package net.seanhess.bif.core
{
	import flash.events.Event;
	
	[Bindable]
	public class Scope implements IScope
	{
		public var event:Event;
		public var target:*;
		public var map:BehaviorMap;
		
		public function Scope(target:*=null, map:BehaviorMap=null, event:Event=null)
		{
			this.target = target;
			this.event = event;
			this.map = map;
		}
	}
}