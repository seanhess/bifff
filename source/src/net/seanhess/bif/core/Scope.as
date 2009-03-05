package net.seanhess.bif.core
{
	import flash.events.Event;
	
	[Bindable]
	public class Scope implements IScope
	{
		public var event:Event;
		public var target:*;
		
		public function Scope(target:*=null, event:Event=null)
		{
			this.target = target;
			this.event = event;
		}
	}
}