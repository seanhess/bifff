package net.seanhess.bifff.sugar
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import net.seanhess.bifff.behaviors.Set;
	import net.seanhess.bifff.core.ISelector;
	import net.seanhess.bifff.core.Selector;
	
	use namespace flash_proxy;
	
	/**
	 * <Injector match="" myproperty="myValue"/>
	 * 
	 * replaces
	 * 
	 * <Selector match="">
	 *   <Set myproperty="myValue"/>
	 * </Selector>
	 * 
	 */
	dynamic public class Injector extends Proxy implements ISelector
	{
		public var selector:Selector;
		public var setter:Set;
		
		public function Injector()
		{
			selector = new Selector();
			setter = new Set();
			
			selector.actions = [setter];
		}
		
		/**
		 * Proxy Selector
		 */
		public function set actions(value:Array):void	{ selector.actions = value; }
		public function get actions():Array				{ return selector.actions }
		
		public function set nodes(value:Array):void		{ selector.nodes = value; }
		public function get nodes():Array				{ return selector.nodes;  }
		
		public function set match(value:String):void	{ selector.match = value; }
		
		public function matches(target:*, root:*=null):Boolean	{ return selector.matches(target, root) }
		
		/**
		 * Proxy Setter
		 */
		override flash_proxy function setProperty(name:*, value:*):void
		{
			setter[name] = value;
		}
		
	}
}