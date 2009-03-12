package net.seanhess.bifff.utils
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	
	public class Defaults
	{
		public var target:*;
		
		public function Defaults(target:*)
		{
			this.target = target;
		}
		
		/**
		 * Reflects through the target, looking for a particular type
		 */
		public function scan(type:Class):Array
		{
			if (findings[type] == null)
				findings[type] = forcedScan(type);
				
			return findings[type];
		} 
		
		public function forcedScan(type:Class):Array
		{
			var info:XML = describeType(target);
			var properties:XMLList = info..accessor + info..variable;
			
			var found:Array = [];
			
			for each (var property:XML in properties)
			{
				try {
					var value:* = target[property.@name.toString()];
					if (value is type)
						found.push(value);
				}
				catch (e:Error)
				{
					
				}
			}
			
			return found;
		}
		
		protected var findings:Dictionary = new Dictionary(true);
	}
}