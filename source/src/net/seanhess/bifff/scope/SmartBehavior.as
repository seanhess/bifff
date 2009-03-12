package net.seanhess.bifff.scope
{
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.scope.SmartObject;
	
	[Bindable]
	dynamic public class SmartBehavior extends SmartObject
	{
		public function SmartBehavior()
		{
			super(Scope.BEHAVIOR);
		}

	}
}