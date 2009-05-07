package net.seanhess.bifff.behaviors
{
	import net.seanhess.bifff.utils.Targets;

	/**
	 * Sets the target of all of its actions to it's own target. 
	 * Useful when you AREN'T using a selector. 
	 */
	[DefaultProperty("behaviors")]
	public class Target
	{
		private var _behaviors:Array;
		private var targets:Targets = new Targets();
		
		public function set target(value:*):void
		{
			if (value)
			{
				targets.add(value);
				init();
			}
		}
		
		[ArrayElementType("Object")]
		public function set behaviors(value:Array):void
		{
			_behaviors = value;
			init();		
		}
		
		private function init():void
		{
			if (_behaviors)
			{
				targets.eachUnapplied(
					function(target:*):void 
					{
						for each (var behavior:* in _behaviors)
						{
							if (behavior.hasOwnProperty("target"))
								behavior.target = target;
						}
					}
				);
			}
		}
	}
}