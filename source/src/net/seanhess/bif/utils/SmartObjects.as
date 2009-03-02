package net.seanhess.bif.utils
{
	import net.seanhess.bif.core.SmartObject;
	
	[Bindable]
	public class SmartObjects
	{
		public var event:SmartObject = new SmartObject(SmartObject.EVENT);
		public var target:SmartObject = new SmartObject(SmartObject.TARGET);
	}
}