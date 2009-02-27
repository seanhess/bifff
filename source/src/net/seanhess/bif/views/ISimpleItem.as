package net.seanhess.bif.views
{
	import mx.core.IDataRenderer;
	
	public interface ISimpleItem extends IDataRenderer
	{
		function getChildren():Array;
		function removeAllChildren():void;
	}
}