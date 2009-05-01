package net.seanhess.bifff.core
{
	public interface ISelector extends IScopeable
	{
		function set actions(value:Array):void;
		function get actions():Array;
		
		function set nodes(value:Array):void;
		function get nodes():Array;
		
		function set match(value:String):void;
		
		function get scope():Scope;
		
		function matches(target:*, root:*=null):Boolean;
	}
}