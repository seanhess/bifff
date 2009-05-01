package net.seanhess.bifff.behaviors
{
	import net.seanhess.bifff.core.MultiStyleDeclaration;
	
	/**
	 * This allows a UIComponent to have multiple styles
	 * and to have them all apply (from the stylesheet)
	 * 
	 * Notice you don't have to implement IBehavior
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