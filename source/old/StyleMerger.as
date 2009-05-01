package net.seanhess.bifff.core
{
	public class StyleMerger
	{
		public function addClass(target:*, style:String):void
		{
			var styleName:String = target.styleName || "";
			styleName += " " + style;
			target.styleName = styleName;
		}
		
		// "one two three" "one" "two one"
		public function removeClass(target:*, style:String):void
		{
			var styleName:String = target.styleName || "";
			var regex:RegExp = new RegExp("\\s" + style);
			styleName = styleName.replace(regex, "");
			target.styleName = styleName;
		}
	}
}