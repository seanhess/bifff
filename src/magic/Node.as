package magic
{
	public class Node
	{
		public static const TYPE:String = "class";
		public static const STYLE:String = "style";
		public static const ANY:String = "any";
		
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