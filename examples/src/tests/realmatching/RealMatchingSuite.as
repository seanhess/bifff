package tests.realmatching
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	public class RealMatchingSuite extends TestSuite
	{
		public function RealMatchingSuite()
		{
			addTestCase(new TestMatchInstance());
		}

	}
}