package net.seanhess.bif.utils
{
	import net.seanhess.bif.core.Scope;
	import net.seanhess.bif.core.SmartObject;
	
	[Bindable]
	dynamic public class SmartTarget extends SmartObject
	{
		public function SmartTarget()
		{
			super(Scope.TARGET);
		}

	}
}