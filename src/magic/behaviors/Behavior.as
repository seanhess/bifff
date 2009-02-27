package magic.behaviors
{
	import flash.display.DisplayObject;
	
	import mx.core.UIComponent;
	
	public class Behavior implements IBehavior
	{
		public function set target(value:DisplayObject):void
		{
			_target = value;
		}
		
		public function get target():DisplayObject
		{
			return _target;
		}
		
		public function get component():UIComponent
		{
			return _target as UIComponent;
		}
		
		public function add():void 
		{
			
		}
		
		public function remove():void
		{
			
		}
		
		protected var _target;
	}
}