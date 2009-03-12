package net.seanhess.bifff.scope
{
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.scope.SmartObject;
	
	[Bindable]
	dynamic public class SmartBehaviorTarget extends SmartObject
	{
		public function SmartBehaviorTarget()
		{
			super(Scope.BEHAVIOR_TARGET);
		}

	}
}