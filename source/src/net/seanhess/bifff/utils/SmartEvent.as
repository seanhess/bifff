package net.seanhess.bif.utils
{
	import net.seanhess.bif.core.Scope;
	import net.seanhess.bif.core.SmartObject;
	
	[Bindable]
	dynamic public class SmartEvent extends SmartObject
	{
		public function SmartEvent()
		{
			super(Scope.EVENT);
		}
	}
}