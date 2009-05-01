package net.seanhess.bifff.behaviors
{
	import flash.events.EventDispatcher;
	
	import net.seanhess.bifff.core.MultiStyleDeclaration;
	import net.seanhess.bifff.utils.Targets;
	
	/**
	 * Allows you to add and remove styles
	 */
	public class Styles extends EventDispatcher
	{
		protected var classesToAdd:Array = [];
		protected var classesToRemove:Array = [];
		protected var targets:Targets = new Targets();
		
		public function set target(value:*):void
		{
			targets.add(value);
			apply(value);
		}
		
		public function apply(target:*):void
		{
			var declaration:MultiStyleDeclaration = target.styleName as MultiStyleDeclaration || new MultiStyleDeclaration(target.styleName, target);
			
			for each (var add:String in classesToAdd)
			{
				declaration.addStyle(add);
			}
			
			for each (var remove:String in classesToRemove)
			{
				declaration.removeStyle(remove);
			}
			
			declaration.forceUpdate();	// sets itself to the target
		}
		
		public function set addClass(value:Object):void
		{
			if (value is String)
				value = [value];
				
			classesToAdd = value as Array;
		}
		
		/**
		 * TODO: Add support for undoing actions, otherwise, this won't do anything.
		 * 
		 * Well, it will work so long as another styleName is undoing it
		 */
		public function set removeClass(value:Object):void
		{
			if (value is String)
				value = [value];
				
			classesToRemove = value as Array;
		}
		
	}
}