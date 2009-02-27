package magic.behaviors
{
	/**
	 * One issue... it doesn't make sense to store the target, since this is reused. It needs to have add(target) and remove(target)
	 */
	public class Behavior implements IBehavior
	{
		public function add(target:*):void 
		{
		}
		
		public function remove(target:*):void
		{
		}
	}
}