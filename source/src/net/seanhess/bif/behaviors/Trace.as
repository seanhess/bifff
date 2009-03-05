package net.seanhess.bif.behaviors
{
	import net.seanhess.bif.core.Scope;
	
	public class Trace implements IBehavior
	{
		public var message:String = "alert";
		
		public function apply(scope:Scope):void
		{
			trace(message);
		}
	}
}