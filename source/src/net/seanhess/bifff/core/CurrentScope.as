package net.seanhess.bifff.core
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	dynamic public class CurrentScope extends Proxy
	{
		override flash_proxy function getProperty(name:*):* 
		{
			return Scope.current[name];
	    }
	}
}