package net.seanhess.bifff.core
{
	import flash.display.DisplayObject;
	
	[DefaultProperty("actions")]
	public class Selector implements ISelector
	{
		public var parser:IParser = new Parser();
		public var matcher:IMatcher = new Matcher();
		
		public function set nodes(value:Array):void
		{
			_nodes = value;
		}
		
		public function get nodes():Array
		{
			return _nodes;
		}
		
		[ArrayElementType("Object")]
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
		
		public function matches(target:*, root:*=null):Boolean
		{
			return matcher.match(target, nodes, root as DisplayObject);
		}
		
//		public function set parent(value:Scope):void
//		{
//			scope.parent = value;
//		}
		
		protected var _match:String = "";
		protected var _actions:Array;
		protected var _nodes:Array;
		protected var _targets:Array;
	}
}