package net.seanhess.bifff.core
{
	import flash.display.DisplayObject;
	
	import net.seanhess.bifff.scope.IScopeable;
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.utils.Scoper;
	
	[DefaultProperty("actions")]
	public class Selector implements ISelector, IScopeable
	{
		public var debug:Boolean = false;
		public var parser:IParser = new Parser();
		public var matcher:IMatcher = new Matcher();
		public var scoper:Scoper = new Scoper();
		
		private var scope:Scope;
		
		public function Selector()
		{
			scope = new Scope({selector:this});
		}
		
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
			scoper.parentScopes(_actions, scope);
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
		
		public function set parent(value:Scope):void
		{
			scope.parent = value;
		}
		
		protected var _match:String;
		protected var _actions:Array;
		protected var _nodes:Array;
		protected var _targets:Array;
	}
}