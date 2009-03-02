package net.seanhess.bif.utils
{
	import net.seanhess.bif.core.ISmartObject;
	import net.seanhess.bif.core.SmartObject;
	
	[Bindable]
	public class SmartObjects
	{
		public var event:Object = new SmartObject(SmartObject.EVENT);
		public var target:Object = new SmartObject(SmartObject.TARGET);
	}
}