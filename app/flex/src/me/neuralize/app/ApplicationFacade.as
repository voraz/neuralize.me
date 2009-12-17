package me.neuralize.app{
	import me.neuralize.app.controller.StartupCommand;
	import me.neuralize.app.view.ApplicationMediator;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade{
		
		public static const STARTUP:String = "startup";
		
		public static function getInstance():ApplicationFacade{
			if(instance==null){
				instance = new ApplicationFacade();
				instance.sendNotification(STARTUP)
			}
			return instance as ApplicationFacade;
		}
		
		override protected function initializeController():void{
			super.initializeController();
			registerCommand(STARTUP, StartupCommand);
		}
		
		
		public function get app():Neuralize{
			var mediator:ApplicationMediator = instance.retrieveMediator( ApplicationMediator.NAME ) as ApplicationMediator
			return mediator.app
		}
	}
}