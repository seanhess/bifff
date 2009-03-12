package net.seanhess.bifff.utils
{
	import net.seanhess.bifff.core.Scope;
	import net.seanhess.bifff.core.SmartObject;
	
	[Bindable]
	dynamic public class SmartEvent extends SmartObject
	{
		public function SmartEvent()
		{
			super(Scope.EVENT);
		}
	}
}