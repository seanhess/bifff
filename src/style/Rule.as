package style
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.core.Container;
	import mx.events.FlexEvent;
	
	[DefaultProperty("actions")]
	dynamic public class Rule extends Object
	{
		public var actions:Array;
		public var paths:Array;
		
		public function set path(value:String):void
		{
			value = value || "";
			
			var items:Array = value.split(/\s/i);
			this.paths = [];
			
			for each (var item:String in items)			
			{
				var match:Array = item.match(/^(\.|#)?(.*)$/i);
				var token:String = match[1];
				var name:String = match[2];
				
				var path:PathItem = new PathItem();
				
				switch(token)
				{
					case '#':	path.type = PathItem.ID; 	break;
					case '.':	path.type = PathItem.CLASS;	break;
					default:	path.type = PathItem.TAG;	break;
				}
				
				path.value = name;		
				
				this.paths.push(path);
			}
			
			return;
		}
		
		public function set base(value:Container):void
		{
			// I need to listen for creation Complete
			
			if (value)
			{
				value.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			}
			
		}
		
		protected function onCreationComplete(event:Event):void
		{
			var me:Container = event.target as Container;
			
			executePath(me, paths.concat());
		}
		
		protected function executePath(base:DisplayObjectContainer, paths:Array):void
		{
			// do yer path! // 
			// I'm looking for a particular class // 
			// I need some good descendant functions or whatever // 
			// Maybe it would be better to go through the PATH one thing at a time. //
			
//			var matches:Array = getMatches(base, paths);			
		}
		
		protected function getMatches(base:DisplayObjectContainer, paths:Array):void
		{
			
		}
	}

}


class PathItem
{
	public static const ID:String = "id";
	public static const CLASS:String = "class";
	public static const TAG:String = "tag";
	
	public var type:String;
	public var value:String;	
}