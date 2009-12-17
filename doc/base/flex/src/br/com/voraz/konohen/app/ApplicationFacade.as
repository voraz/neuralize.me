package br.com.voraz.konohen.app{
	import br.com.voraz.konohen.app.controller.StartupCommand;
	import br.com.voraz.konohen.konohen.controller.KonohenController;
	import br.com.voraz.konohen.konohen.model.KohonenProxy;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;

	public class ApplicationFacade extends Facade implements IFacade{
		
		public static const STARTUP:String = "startup";
		
		public static function getInstance():ApplicationFacade{
			if(instance==null){
				instance = new ApplicationFacade();
			}
			return instance as ApplicationFacade;
		}
		
		override protected function initializeController():void{
			super.initializeController();

			registerCommand(STARTUP, StartupCommand);
			registerCommand(KohonenProxy.EXECUTE, KonohenController);
		}
		
		public function startup(index:Object):void{
			sendNotification(STARTUP, index);
		}
		
		
	}
}