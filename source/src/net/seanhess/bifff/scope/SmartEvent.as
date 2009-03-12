package net.seanhess.bifff.scope
{
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.scope.SmartObject;
	
	[Bindable]
	dynamic public class SmartEvent extends SmartObject
	{
		public function SmartEvent()
		{
			super(Scope.EVENT);
		}
	}
}