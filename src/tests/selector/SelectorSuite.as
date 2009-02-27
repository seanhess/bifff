package tests.selector
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	public class SelectorSuite extends TestSuite
	{
		public function SelectorSuite()
		{
			addTestCase(new TestParsing());
			addTestCase(new TestParsingValue());
		}

	}
}