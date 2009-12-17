package me.neuralize.app.controller{
	import br.com.voraz.flash.connection.Connection;
	import br.com.voraz.flash.validators.DataTypeValidator;
	import br.com.voraz.flexLib.conection.HTTPServiceConnection;
	
	import com.asual.swfaddress.SWFAddress;

	public class InitializerCommand	{
		private static var initialized:Boolean = false;
		
		public static function initialize():void{
			if( initialized==false ){
				
				try{
					if( DataTypeValidator.string(SWFAddress.getBaseURL()) ){
						online() 
					}else{
						offline()
					}
				}catch(e:*){
					online()
				}
				online()
				initialized = true
				Connection.ONLINE = true
			}
		}
		
		private static function online():void{
			HTTPServiceConnection.urlBase = "http://localhost:3000"
			//HTTPServiceConnection.urlBase = "http://192.168.0.103:3000"			
		}
		private static function offline():void{
			Connection.ONLINE = true
		}
		
	}
}