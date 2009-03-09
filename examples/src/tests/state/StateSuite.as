package tests.state
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	public class StateSuite extends TestSuite
	{
		public function StateSuite()
		{
			addTestCase(new TestUpdateState());
		}

	}
}