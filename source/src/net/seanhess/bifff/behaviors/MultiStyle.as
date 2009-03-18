package net.seanhess.bifff.behaviors
{
	import mx.core.UIComponent;
	
	import net.seanhess.bifff.core.MultiStyleDeclaration;
	import net.seanhess.bifff.utils.TargetRegistry;
	
	/**
	 * This allows a UIComponent to have multiple styles
	 * and to have them all apply (from the stylesheet)
	 * 
	 * See, this is a classic example. I immediately apply
	 * myself it. 
	 */
	public class MultiStyle
	{
		protected var registry:TargetRegistry = new TargetRegistry(apply, true);
		
		public function set target(value:*):void
		{
			registry.applyTargets(value);
		}
		
		public function apply(value:*):void
		{
			if (value is UIComponent)
				if (value.styleName is String)
					value.styleName = new MultiStyleDeclaration(value.styleName as String);
		}
		
	}
}