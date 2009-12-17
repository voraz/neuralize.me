package br.com.voraz.konohen.konohen.model{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class KohonenProxy extends Proxy implements IProxy{
		public static const NAME:String = "KohonenProxy"; 
		
		public static const EXECUTE:String = "KohonenProxy_EXECUTE"
		public static const ADDTEXT:String = NAME+"add_text"
		
		public function KohonenProxy(data:Object=null){
			super(NAME, data);
		}
				
	}
}