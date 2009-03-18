package net.seanhess.bifff.behaviors
{
	import mx.core.UIComponent;
	
	import net.seanhess.bifff.core.MultiStyleDeclaration;
	
	/**
	 * This allows a UIComponent to have multiple styles
	 * and to have them all apply (from the stylesheet)
	 * 
	 * See, this is a classic example. I immediately apply
	 * myself it. 
	 */
	public class MultiStyle
	{
		public function set target(value:UIComponent):void
		{
			if (value.styleName is String)
				value.styleName = new MultiStyleDeclaration(value.styleName as String);
		}
	}
}