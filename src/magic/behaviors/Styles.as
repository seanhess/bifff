package magic.behaviors
{
	import flash.utils.Dictionary;
	
	public class Styles implements IBehavior
	{
		protected var views:Dictionary = new Dictionary(true);
		
		public function add(target:*):void
		{
			views[target] = true;
		}
		
		public function remove(target:*):void
		{
			delete views[target];
		}
		
		public function updateStyleDeclaration():void
		{
			// can I really add multiples here?
			// How would it work?
		}
		
		public function set addClass(value:Object):void
		{
			if (value is String)
				value = [value];
				
			classesToAdd = value;
		}
		
		public function set removeClass(value:Object):void
		{
			if (value is String)
				value = [value];
				
			classesToRemove = value;
		}
		
		protected var classesToAdd:Array = [];
		protected var classesToRemove:Array = [];
	}
}