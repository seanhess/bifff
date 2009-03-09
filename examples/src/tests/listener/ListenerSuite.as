package tests.listener
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	public class ListenerSuite extends TestSuite
	{
		public function ListenerSuite()
		{
			addTestCase(new TestUpdateState());
			addTestCase(new TestBinding());
		}

	}
}