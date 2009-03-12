package net.seanhess.bifff.utils
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.UIComponent;
	
	import net.seanhess.bifff.core.ISelector;
	
	public class Debugger
	{
		
		protected var matches:Dictionary;
		
		public function set target(value:DisplayObject):void
		{
			matches = new Dictionary(true);
			value["doubleClickEnabled"] = true;
			value.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick, false, 0, true);
			_target = value;
		}
		
		protected var _target:DisplayObject;
		
		protected function onDoubleClick(event:MouseEvent):void
		{
			trace("");
			trace("=========================================================");
			trace("                     MATCHES");
			trace("=========================================================");
			trace(dumpMatches());
			
			trace("");
			trace("=========================================================");
			trace("                  DISPLAY OBJECT CLICKED					");
			trace("=========================================================");
			trace(dump(event.target as DisplayObject));
		}
		
		public function match(target:*, selector:ISelector):void
		{
			if (matches[selector] == null)
				matches[selector] = new Dictionary(true);
			
			matches[selector][target] = true;
		}
		
		protected function dumpMatches():String
		{
			var out:String = "";
			
			for (var selector:Object in matches)
			{
				out += "\n";
				out += "\n" + selector;
				out += "\n-------------------------------------";
				
				for (var match:Object in matches[selector])
				{
					var line:String = "\n      ";
					
					for each (var item:String in dumpToArray(match as DisplayObject))
						line += item + "    ";
						
					out += line;
				}
			}
			
			return out;
		}

		protected function dump(target:DisplayObject):String
		{
			var out:String = "";
			
			for each (var item:String in dumpToArray(target))
				out += "      " + item + "\n";
				
			return out;
		}		
		
		protected function dumpToArray(target:DisplayObject):Array
		{
			return openParent(target);
		}
		
		protected function openParent(target:*):Array
		{
			if (target == _target)
				return null;
			
			var me:String = openNode(target);
			
			if (target.parent)
				var parent:Array = openParent(target.parent);
				
			return (parent) ? parent.concat(me) : [me];
		}
		
		protected function openNode(target:*):String
		{
			var start:String = "<" + className(target);
			
			if (target is UIComponent)
			{
				if (target.id)
					start += " id='"+target.id+"'"
					
				if (target.styleName)
					start += " styleName='"+target.styleName+"'"
			}
			 
			start += ">";
			
			return start;  
		}
		
		protected function className(target:*):String
		{
			return getQualifiedClassName(target).replace(/^.*::/,"");
		}
	}
}