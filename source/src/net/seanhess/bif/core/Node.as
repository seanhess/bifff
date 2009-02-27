package net.seanhess.bif.core
{
	public class Node
	{
		public static const CLASS:String = "class";		// Classes, Interfaces, superclass, etc 
		public static const TAG:String = "tag";			// shallow class (specified as a string!)
		public static const STYLE:String = "style";		// styleName
		public static const ID:String = "id";			// id
		public static const MULTI:String = "multi";		// value is an array of nodes that ALL have to match to work
		public static const ANY:String = "any";			// * - matches anything.. Be careful, this is less performance-happy
		public static const META:String = "meta";		// :even and :odd
		
		public var type:String;
		public var value:*;
		
		public function Node(type:String=null, value:*=null)
		{
			this.type = type;
			this.value = value;
		}
		
		public function toString():String
		{
			return type + ": " + value;
		}
	}
}