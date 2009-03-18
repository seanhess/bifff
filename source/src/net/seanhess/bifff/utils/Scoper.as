package net.seanhess.bifff.utils
{
	import net.seanhess.bifff.scope.IScopeable;
	import net.seanhess.bifff.scope.Scope;
	
	public class Scoper
	{
		public function parentScopes(list:Array, scope:Scope):void
		{
			for each (var target:* in list)
				parentScope(target, scope);	
		}
		
		public function parentScope(target:*, scope:Scope):void
		{
			if (target && target is IScopeable)
				target.parent = scope;
		}
	}
}