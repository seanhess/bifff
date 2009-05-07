package net.seanhess.bifff.behaviors
{
	import net.seanhess.bifff.core.MultiStyleDeclaration;
	
	/**
	 * This allows a UIComponent to have multiple styles
	 * and to have them all apply (from a normal
	 * flex stylesheet). You don't need to add this behavior
	 * to get multiple styles to match selectors
	 */
	public class MultiStyle
	{
		public function set target(value:*):void
		{
			if (value.hasOwnProperty("styleName"))
			{
				var current:String = "";
								
				if (value.styleName is MultiStyleDeclaration)
					return;
					
				if (value.styleName is String)
					current = value.styleName;
					
				else if (value.styleName == null)
					return;
				
				value.styleName = new MultiStyleDeclaration(current);
			}
		}
	}
}