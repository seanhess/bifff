package tests.setandget
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	public class SetAndGetSuite extends TestSuite
	{
		public function SetAndGetSuite()
		{
			addTestCase(new TestGet());
			addTestCase(new TestSet());
		}

	}
}