package tests.behaviors
{
	import net.seanhess.bifff.behaviors.IBehavior;
	
	public class SimpleBehavior implements IBehavior
	{
		public function set target(value:*):void
		{
			value["width"] = 300;
		}
	}
}