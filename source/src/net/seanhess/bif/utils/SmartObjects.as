package net.seanhess.bif.utils
{
	import net.seanhess.bif.core.Scope;
	import net.seanhess.bif.core.SmartObject;
	
	[Bindable]
	public class SmartObjects
	{
		public var event:Object = new SmartObject(Scope.EVENT);
		public var target:Object = new SmartObject(Scope.TARGET);
	}
}