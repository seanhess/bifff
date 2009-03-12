package net.seanhess.bifff.core
{
	public interface IParser
	{
		function parseMatch(value:String):Array;
		function parseItem(item:String):Node;
		function parseMulti(itemList:String):Array;
	}
}