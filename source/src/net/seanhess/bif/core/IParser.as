package net.seanhess.bif.core
{
	public interface IParser
	{
		function parseMatch(value:String):Array;
		function parseItem(item:String):Node;
		function parseMulti(itemList:String):Array;
	}
}