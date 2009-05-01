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
				var current:String = value.styleName as String;
				
				if (current == null)
					current = "";

				value.styleName = new MultiStyleDeclaration(current);
			}
		}
	}
}