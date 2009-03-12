package net.seanhess.bifff.scope
{
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.scope.SmartObject;
	
	[Bindable]
	dynamic public class SmartListenerTarget extends SmartObject
	{
		public function SmartListenerTarget()
		{
			super(Scope.LISTENER_TARGET);
		}

	}
}