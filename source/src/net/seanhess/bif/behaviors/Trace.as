package net.seanhess.bif.behaviors
{
	public class Trace implements IBehavior
	{
		public var message:String = "alert";
		
		public function apply(target:*):void
		{
			trace(message);
		}
	}
}