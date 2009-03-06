package tests.mateintegration
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	
	public class FakeDispatcher extends EventDispatcher implements IMXMLObject
	{
		public function initialized(document:Object, id:String):void
		{
			this.document = document;
			this.id = id;
			this.dispatchEvent(new FlexEvent(FlexEvent.CREATION_COMPLETE, true));
		}
		
		public function go():void
		{
			var event:Event = new Event("test", true);
			dispatchEvent(event);
		}
		
		public var document:Object;
		public var id:String;
		
	}
}