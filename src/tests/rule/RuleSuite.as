package tests.rule
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	public class RuleSuite extends TestSuite
	{
		public function RuleSuite()
		{
			addTestCase(new TestParsing());
		}

	}
}