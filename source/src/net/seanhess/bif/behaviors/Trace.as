package net.seanhess.bif.behaviors
{
	public class Trace implements IBehavior
	{
		public var message:String = "alert";
		
		public function add(target:*):void
		{
			trace(message);
		}
		
		public function remove(target:*):void
		{
			
		}
	}
}