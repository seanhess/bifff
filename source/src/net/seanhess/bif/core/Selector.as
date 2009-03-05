package net.seanhess.bif.core
{
	import flash.utils.Dictionary;
	
	[DefaultProperty("behaviors")]
	public class Selector implements ISelector
	{
		public var debug:Boolean = false;
		public var parser:IParser = new Parser();
		
		public function set nodes(value:Array):void
		{
			_nodes = value;
		}
		
		public function get nodes():Array
		{
			return _nodes;
		}
		
		public function set behaviors(value:Array):void
		{
			_behaviors = value;
		}
		
		public function get behaviors():Array
		{
			return _behaviors;
		}
		
		public function set match(value:String):void
		{
			_match = value;
			nodes = parser.parseMatch(value);
		}
		
		public function get match():String
		{
			return _match;
		}
		
		public function toString():String
		{
			return _match as String || _match.toString();
		}
		
		protected var _match:String;
		protected var _behaviors:Array;
		protected var _nodes:Array;
		protected var _targets:Array;
	}
}