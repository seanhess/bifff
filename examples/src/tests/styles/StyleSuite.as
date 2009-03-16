package tests.styles
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	public class StyleSuite extends TestSuite
	{
		public function StyleSuite()
		{
			addTestCase(new TestMultiStyleDeclaration());
		}
	}
}