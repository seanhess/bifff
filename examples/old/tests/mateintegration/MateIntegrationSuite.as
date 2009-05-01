package tests.mateintegration
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	public class MateIntegrationSuite extends TestSuite
	{
		public function MateIntegrationSuite()
		{
			addTestCase(new Bubbling());
		}

	}
}