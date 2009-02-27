package magic
{
	import flash.display.DisplayObject;
	
	public interface IMatcher
	{
		function match(item:DisplayObject, nodes:Array):Boolean;
	}
}