package net.seanhess.bifff.examples.behavior
{
	import mx.styles.IStyleClient;

	public class Padding
	{
		public var amount:int = 10;
		
		public function set target(client:IStyleClient):void
		{
			client.setStyle("paddingLeft", amount);
			client.setStyle("paddingRight", amount);
			client.setStyle("paddingBottom", amount);
			client.setStyle("paddingTop", amount);
		}
	}
}