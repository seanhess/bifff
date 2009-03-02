package net.seanhess.bif.behaviors
{
	import net.seanhess.bif.core.IScope;
	
	public class Trace implements IBehavior
	{
		public var message:String = "alert";
		
		public function apply(scope:IScope):void
		{
			trace(message);
		}
	}
}