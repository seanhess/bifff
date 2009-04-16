package net.seanhess.bifff.utils
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	import net.seanhess.bifff.core.ISelector;
	
	[Bindable]
	public class Debug
	{
		public static var instance:Debug = new Debug();
		
		public var enabled:Boolean = true;
		
		public var selectors:Dictionary = new Dictionary(true);
		public var targets:Dictionary = new Dictionary(true);
		
		private var lists:Dictionary = new Dictionary(true);
		
		public function match(selector:ISelector, target:*, matched:Boolean):void
		{
			if (!enabled) return;
			
			if (matched)
			{
				getList(selector).addItem(target);
				getList(target).addItem(selector);			
			}
			
			selectors[selector] = true;		// show your face!
			targets[target] = true;			// so, show your face!
		}
		
		public function getList(item:*):IList
		{
			if (lists[item] == null)
				lists[item] = new ArrayCollection();
				
			return lists[item];
		}
		
		public function get selectorList():IList
		{
			var list:IList = new ArrayCollection();
				
			for (var selector:* in selectors)
			{
				if (selector is ISelector)
					list.addItem(selector);
			}
			
			return list;
		}
		
		public function get targetList():IList
		{
			var list:IList = new ArrayCollection();
				
			for (var target:* in targets)
			{
				list.addItem(target);
			}
			
			return list;
		}
		
		public function message(value:String):void
		{
			if (!enabled) return;
			
			trace(value);	
		}
	}
}