package br.com.voraz.konohen.app.view{
	import br.com.voraz.konohen.app.ApplicationFacade;
	import br.com.voraz.konohen.app.view.components.ApplicationView;
	import br.com.voraz.konohen.disciplines.model.DisciplinesProxy;
	import br.com.voraz.konohen.konohen.view.KonohenMediator;
	import br.com.voraz.konohen.students.model.StudentsProxy;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class ApplicationMediator extends Mediator implements IMediator{
		public static const NAME:String = "ApplicationMediator";
		 
		public function ApplicationMediator(viewComponent:Object=null){
			super(NAME, viewComponent);
		}
		public function get applicationView():ApplicationView{
			return viewComponent as ApplicationView
		}
		
		override public function listNotificationInterests():Array{
			return [
					ApplicationFacade.STARTUP
					];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case ApplicationFacade.STARTUP:
					start();
					break;
			}
		}
		
		override public function onRegister():void{
		}
		
		
		private function start():void{
			facade.registerMediator( new KonohenMediator(this.viewComponent) );
		}
		
	}
}