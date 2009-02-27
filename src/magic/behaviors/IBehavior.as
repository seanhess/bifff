package magic.behaviors
{
	import flash.display.DisplayObject;
	
	public interface IBehavior
	{
		function add():void;
		function remove():void;
		function set target(value:DisplayObject):void; 
	}
}