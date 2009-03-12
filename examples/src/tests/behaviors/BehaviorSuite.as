package tests.behaviors
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	public class BehaviorSuite extends TestSuite
	{
		public function BehaviorSuite()
		{
			addTestCase(new TestSimpleBehavior());
		}
	}
}