package net.seanhess.bif.core
{
	import flash.utils.Dictionary;
	
	/**
	 * Tracks to see if we've already applied a selector to something
	 */
	public class ApplicationTracker
	{
		private var applications:Dictionary = new Dictionary(true);
		
		public function applied(selector:ISelector, target:*):Boolean
		{
			return selectorApplications(selector)[target];
		}
		
		public function apply(selector:ISelector, target:*):void
		{
			selectorApplications(selector)[target] = true;
		}
		
		public function unapply(selector:ISelector, target:*):void
		{
			delete selectorApplications(selector)[target];
		}
		
		protected function selectorApplications(selector:ISelector):Dictionary
		{
			if (!(applications[selector]))
				applications[selector] = new Dictionary(true);
				
			return applications[selector];
		}
	}
}