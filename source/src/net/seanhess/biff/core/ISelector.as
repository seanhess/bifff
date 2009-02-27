package net.seanhess.biff.core
{
	public interface ISelector
	{
		function set behaviors(value:Array):void;
		function get behaviors():Array;
		
		function set nodes(value:Array):void;
		function get nodes():Array;
		
		function set match(value:String):void;
	}
}