package net.seanhess.bif.utils
{
	import net.seanhess.bif.core.ISmartObject;
	import net.seanhess.bif.core.SmartObject;
	
	[Bindable]
	public class SmartObjects
	{
		public var event:* = new SmartObject(SmartObject.EVENT);
		public var target:* = new SmartObject(SmartObject.TARGET);
	}
}