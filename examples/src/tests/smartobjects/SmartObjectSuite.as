package tests.smartobjects
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	public class SmartObjectSuite extends TestSuite
	{
		public function SmartObjectSuite()
		{
			addTestCase(new TestNested());
		}
		

	}
}