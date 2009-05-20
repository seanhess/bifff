package net.seanhess.bifff.extensions
{
	import flash.utils.getDefinitionByName;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import net.seanhess.bifff.behaviors.Behavior;
	import net.seanhess.bifff.behaviors.Set;
	import net.seanhess.bifff.behaviors.Styles;
	import net.seanhess.bifff.core.BehaviorMap;
	import net.seanhess.bifff.core.Selector;

	/**
	 * Generates a behavior map based on a style sheet
	 */
	[DefaultProperty("data")]
	public class BehaviorSheet
	{
		public static const BEHAVIOR:String = "behavior";
		public static const STYLE:String = "style";
		
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
		
		public function set data(value:String):void
		{
			map.selectors = parse(value);
		}
		
		protected function onResult(event:ResultEvent):void
		{
			this.data = event.result as String;
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
			
			// 0 // Remove Comments
			data = data.replace(/\/\*.*?\*\//gmsi, "");

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
			selector.actions = parseValues(matches[2]);
			
			return selector;
		}
		
		/**
		 * Returns an array of actions. If they specify
		 * a behavior, it adds that behavior to the list
		 */
		protected function parseValues(data:String):Array
		{
			var actions:Array = new Array();
			var setter:Set = new Set();
			
			actions.push(setter);
			
			// 3 // Parse the properties
			var parts:RegExp = /[\w_\-]+\s*\:\s*.*?;/gism
			var matches:Array = data.match(parts);
			
			for (var i:int = 0; i < matches.length; i++)
			{
				var match:String = matches[i];
				var value:Object = parseValue(match);
				
				if (value is Styles || value is Behavior)
				{
					actions.push(value);
				}
				else if (value != null)
				{
					setter[value.property] = value.value;
				}
			}
			
			return actions;
		}
		
		/**
		 * Returns either a normal object with a key/value pair
		 * to be put into the set tag
		 * 
		 * Or returns a full behavior to be added
		 */
		protected function parseValue(data:String):*
		{
			var parts:RegExp = /([\w_\-]+)\s*\:\s*(.*?)\s*(;|,|$)/gism
			var matches:Array = parts.exec(data);
			
			if (matches == null || matches.length < 3)
				throw new Error("Could not parse value: " + data);
				
			var property:String = matches[1].replace(/\-([a-z])/gi, function():String { 
				return arguments[1].toUpperCase();
			});
			
			var value:* = matches[2];
			
			if (property == BEHAVIOR)
			{
//				throw new Error("Deprecated Behavior");
				return parseBehavior(value);
			}
			
			else if (property == STYLE)
			{
//				throw new Error("Deprecated Style");
				return parseStyle(value);
			}

			else if (value.match(/^([\d\.]+)(px|em|pt)?$/i))
			{
				var sanitized:String = value.replace(/[^\d\.]/gi, ""); 
				value = parseFloat(sanitized);
			}
			
			else if (value == "true" || value == "false")
			{
				value = new Boolean(value);
			}
			
			else
			{
				value = value.replace(/(^[\"\']|[\"\']$)/gi, "");
			}
			
			return {property: property, value: value};
		}
		
		protected function parseStyle(value:String):Styles
		{
			var styles:Styles = new Styles();
				styles.addClass = value;
				
			return styles;
		}
		
		protected function parseBehavior(value:String):Behavior
		{
			var behavior:Behavior = new Behavior();
			
			var sections:Array = value.match(/([\w\.]+)(\((.*)\))?/im);
			
			if (sections == null)
				throw new Error("Error parsing Behavior: " + value);
			
			var className:String = sections[1]; 
			
			if (sections[3])
			{
				var matches:Array = sections[3].split(/\s*,\s*/gi);
				
				for each (var match:String in matches)
				{
					var pair:Object = parseValue(match);
					behavior[pair.property] = pair.value;
				}
			}
						
			try {
				behavior.generator = getDefinitionByName(className) as Class;
			}
			catch (e:Error)
			{
				throw new Error("Could not find class: " + className);
			}
					
			return behavior;
		}
	}
}