package magic
{
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	
	public class Div extends UIComponent implements IDataRenderer
	{
		public var style:String;
		
		protected var instance:UIComponent;
		
		public function set data(value:Object):void
		{
			_data = value;
			
			if (instance)
				(instance as IDataRenderer).data = value;
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set view(value:Class):void
		{
			_view = value;
			_viewChanged = true;
			invalidateDisplayList();
		}
		
		public function get view():Class
		{
			return _view;	
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (_viewChanged)
			{
				if (instance)
					this.removeChild(instance);
					
				_viewChanged = false;
				instance = new view();
				(instance as IDataRenderer).data = data;
				addChild(instance);
				
				invalidateDisplayList();
			}
		}
		
		// HTML has width = 100% and height = 100% as the default. you can scale it, but you can't measure
		// That's a big downside, not being able to measure. I don't want to lose that. 
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			// well, pretend it's hard coded for now
			if (instance)
			{
				instance.explicitWidth = unscaledWidth;
				instance.explicitHeight = unscaledHeight;
			}
		}
		
		// data, view, style // 
		// view functionality is provided in the view ! // 
		
		
		
		/// BLAH ///
		protected var _view:Class;
		protected var _viewChanged:Boolean = false;
		protected var _data:Object;
	}
}