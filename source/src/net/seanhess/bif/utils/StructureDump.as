package net.seanhess.bif.utils
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.UIComponent;
	
	public class StructureDump
	{
		public function set target(value:UIComponent):void
		{
			value.doubleClickEnabled = true;
			value.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick, false, 0, true);
			_target = value;
		}
		
		protected var _target:UIComponent;
		
		protected function onDoubleClick(event:MouseEvent):void
		{
			trace("");
			trace("-----------------------------------");
			trace(dump(event.target as DisplayObject));
			trace("-----------------------------------");
		}
		
		protected function dump(target:DisplayObject):String
		{
			return openParent(target);
		}
		
		protected function openParent(target:*):String
		{
			if (target == _target)
				return null;
			
			var me:String = openNode(target);
			
			if (target.parent)
			{
				var parent:String = openParent(target.parent);
				if (parent)
					me = parent + "\n" + me;
			}
				
			return me;
		}
		
		protected function openNode(target:*):String
		{
			var start:String = "<" + className(target);
			
			if (target is UIComponent)
			{
				if (target.id)
					start += " id='"+target.id+"'"
					
				if (target.styleName)
					start += " class='"+target.styleName+"'"
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