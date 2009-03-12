package net.seanhess.bifff.scope
{
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.scope.SmartObject;
	
	[Bindable]
	dynamic public class SmartCurrentTarget extends SmartObject
	{
		public function SmartCurrentTarget()
		{
			super(Scope.CURRENT_TARGET);
		}

	}
}