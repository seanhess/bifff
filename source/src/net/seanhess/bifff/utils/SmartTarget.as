package net.seanhess.bifff.utils
{
	import net.seanhess.bifff.core.Scope;
	import net.seanhess.bifff.core.SmartObject;
	
	[Bindable]
	dynamic public class SmartTarget extends SmartObject
	{
		public function SmartTarget()
		{
			super(Scope.TARGET);
		}

	}
}