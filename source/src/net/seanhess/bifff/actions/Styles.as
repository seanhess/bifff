package net.seanhess.bifff.actions
{
	import flash.events.Event;
	
	import net.seanhess.bifff.core.BehaviorMap;
	import net.seanhess.bifff.core.MultiStyleDeclaration;
	import net.seanhess.bifff.core.StyleMerger;
	import net.seanhess.bifff.scope.Scope;
	
	/**
	 * Allows you to add and remove styles
	 */
	public class Styles implements IAction
	{
		protected var classesToAdd:Array = [];
		protected var classesToRemove:Array = [];
		public var merger:StyleMerger = new StyleMerger();
		
		public function apply(scope:Scope):void
		{
			var declaration:MultiStyleDeclaration = scope.target.styleName as MultiStyleDeclaration || new MultiStyleDeclaration(scope.target.styleName, scope.target);
			
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