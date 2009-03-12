package net.seanhess.bifff.core
{
	import flash.utils.Dictionary;
	
	[DefaultProperty("actions")]
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
		
		public function set actions(value:Array):void
		{
			_actions = value;
		}
		
		public function get actions():Array
		{
			return _actions;
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
		protected var _actions:Array;
		protected var _nodes:Array;
		protected var _targets:Array;
	}
}