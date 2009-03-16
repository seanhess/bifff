package net.seanhess.bifff.actions
{
	import flash.events.EventDispatcher;
	
	import net.seanhess.bifff.core.BifffEvent;
	import net.seanhess.bifff.core.MultiStyleDeclaration;
	import net.seanhess.bifff.core.StyleMerger;
	import net.seanhess.bifff.scope.Scope;
	
	/**
	 * Allows you to add and remove styles
	 */
	[Event(name="updatedStyle",type="net.seanhess.bifff.core.BifffEvent")]
	public class Styles extends EventDispatcher implements IAction
	{
		protected var classesToAdd:Array = [];
		protected var classesToRemove:Array = [];
		public var merger:StyleMerger = new StyleMerger();
		public var debug:Boolean = false;
		
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
			
			if (debug)
			{
				var event:BifffEvent = new BifffEvent(BifffEvent.UPDATED_STYLE);
					event.matchedTarget = scope.target;
					
				dispatchEvent(event);	
			}
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