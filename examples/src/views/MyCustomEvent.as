package views
{
	import flash.events.Event;
	
	/**
	 * An example bubbling event for Mate
	 */
	public class MyCustomEvent extends Event
	{
		public static const MY_TYPE:String = "myType_MyCustomEvent";
		
		public var importantMessage:String;
		
		public function MyCustomEvent(type:String)
		{
			super(type, true);
		}

	}
}