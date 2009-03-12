package net.seanhess.bifff.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import net.seanhess.bifff.utils.Invalidator;
	
	/**
	 * Automatically matches and applies the actions to the target/targets specified
	 * Can go in or out of a behavior map (doesn't have anything to do with them)
	 */
 	[DefaultProperty("actions")]
 	[Event(name="initialized",type="flash.events.Event")]
	public class Apply extends EventDispatcher
	{
		public static const INITIALIZED:String = "initialized";
		
		public var executor:IExecutor = new Executor();
		public var invalidator:Invalidator = new Invalidator(commit);
		
		public var debug:Boolean = false;
		
		/**
		 * Target or targets
		 */
		public function set target(value:Object):void
		{
			if (!(value is Array))
				value = [value];
				
			targets = value as Array;
			invalidator.invalidate();
		}
		
		protected function commit():void
		{
			executor.executeMatches(targets, _actions);
			
			if (debug)
				dispatchEvent(new Event(INITIALIZED));
		}
		
		public function set actions(value:Array):void
		{
			_actions = value;
		}
		
		protected var targets:Array;
		protected var _actions:Array;
	}
}