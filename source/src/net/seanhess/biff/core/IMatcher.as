package net.seanhess.biff.core
{
	import flash.display.DisplayObject;
	
	public interface IMatcher
	{
		function match(item:DisplayObject, nodes:Array, root:DisplayObject=null):Boolean;
	}
}