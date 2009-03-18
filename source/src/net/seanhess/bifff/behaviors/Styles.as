package net.seanhess.bifff.behaviors
{
	import flash.events.EventDispatcher;
	
	import net.seanhess.bifff.behaviors.IBehavior;
	import net.seanhess.bifff.events.BifffEvent;
	import net.seanhess.bifff.core.MultiStyleDeclaration;
	import net.seanhess.bifff.core.StyleMerger;
	import net.seanhess.bifff.scope.IScopeable;
	import net.seanhess.bifff.scope.Scope;
	import net.seanhess.bifff.utils.TargetRegistry;
	
	/**
	 * Allows you to add and remove styles
	 */
	[Event(name="updatedStyle",type="net.seanhess.bifff.events.BifffEvent")]
	public class Styles extends EventDispatcher implements IBehavior, IScopeable
	{
		protected var classesToAdd:Array = [];
		protected var classesToRemove:Array = [];
		public var merger:StyleMerger = new StyleMerger();
		public var debug:Boolean = false;
		
		protected var scope:Scope = new Scope();
		protected var registry:TargetRegistry = new TargetRegistry(apply);
		
		public function set target(value:*):void
		{
			registry.applyTargets(value);
		}
		
		public function set parent(value:Scope):void
		{
			scope.parent = value;
		}
		
		public function apply(target:*):void
		{
			scope.target = target;
			
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