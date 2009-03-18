package net.seanhess.bifff.extensions
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import net.seanhess.bifff.behaviors.Set;
	import net.seanhess.bifff.core.BehaviorMap;
	import net.seanhess.bifff.core.Selector;
	
	/**
	 * Generates a behavior map based on a style sheet
	 */
	public class Style
	{
		public var map:BehaviorMap = new CachingBehaviorMap();
		
		/**
		 * Runtime path to a stylesheet, or embedded data?
		 */
		public function set url(value:String):void
		{
			var service:HTTPService = new HTTPService();
				service.url = value;
				service.resultFormat = "text";
				service.addEventListener(ResultEvent.RESULT, onResult);
				service.addEventListener(FaultEvent.FAULT, onFault);
				service.send();
		}
		
		protected function onResult(event:ResultEvent):void
		{
			map.selectors = parse(event.result as String);
		}
		
		protected function onFault(event:FaultEvent):void
		{
			throw new Error("bifff:Style - fault when loading url - " + event.fault);
		}
		
		public function set target(value:*):void
		{
			map.target = value;		
		}
		
		protected function parse(data:String):Array
		{
			var selectors:Array = [];

			// 1 // Split into declarations
			var declarations:RegExp = /[\w\.\s_#:\-]+\s*\{.*?}/gmsi
			var matches:Array = data.match(declarations);
			
			if (matches == null)
				throw new Error("Could not parse stylesheet: " + data);
			
			for (var i:int = 0; i < matches.length; i++)
			{
				var match:String = matches[i];
				selectors.push(parseDeclaration(match));
			}
			
			
			return selectors;
		}
		
		protected function parseDeclaration(data:String):Selector
		{
			// 1 // Create the Selector
			var selector:Selector = new Selector();
			
			// 2 // Set the match
			var parts:RegExp = /\s*([\w\.\s_#:\-]+?)\s*\{(.*?)}/imsg
			var matches:Array = parts.exec(data);
			
			if (matches == null || matches.length < 3)
				throw new Error("Could not marse declaration:  "+ data); 
			
			selector.match = matches[1];
			
			// 3 // Parse the setters
			selector.actions = [parseValues(matches[2])];
			
			return selector;
		}
		
		protected function parseValues(data:String):Set
		{
			var setter:Set = new Set();
			
			// 3 // Parse the properties
			var parts:RegExp = /[\w_\-]+\s*\:\s*.*?;/gism
			var matches:Array = data.match(parts);
			
			for (var i:int = 0; i < matches.length; i++)
			{
				var match:String = matches[i];
				var value:Object = parseValue(match);
				setter[value.property] = value.value;
			}
			
			return setter;
		}
		
		protected function parseValue(data:String):Object
		{
			var parts:RegExp = /([\w_\-]+)\s*\:\s*(.*?)\s*;/gism
			var matches:Array = parts.exec(data);
			
			if (matches == null || matches.length < 3)
				throw new Error("Could not parse value: " + data);
				
			var property:String = matches[1].replace(/\-([a-z])/, function():String { 
				return arguments[1].toUpperCase();
			});
				
			return {property: property, value: matches[2]};
		}
	}
}