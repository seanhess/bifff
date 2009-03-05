package tests.selfselection
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	public class SelfSelectionSuite extends TestSuite
	{
		public function SelfSelectionSuite()
		{
			addTestCase(new SelectSelf());
		}

	}
}