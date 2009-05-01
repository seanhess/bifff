package tests.matcher
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	public class MatcherSuite extends TestSuite
	{
		public function MatcherSuite()
		{
			this.addTestCase(new TestBasicMatching());
			this.addTestCase(new TestRecursiveMatching());
			this.addTestCase(new TestMultipleMatching());
		}

	}
}