package net.seanhess.bif.views
{
	import mx.core.UIComponent;
	
	/**
	 * You can implement this interface to get special consideration with
	 * the Swap behavior. It will call this function instead of doing any
	 * custom mapping. In other words, it swap, but not copy data, styles, 
	 * id, or children
	 */
	public interface ISwappable
	{
		/**
		 * try not to store a reference to the old view to avoid memory issues.
		 * You can copy its children here yourself
		 */
		function copyView(view:UIComponent):void;
	}
}