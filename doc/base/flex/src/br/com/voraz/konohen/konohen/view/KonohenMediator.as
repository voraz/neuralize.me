package br.com.voraz.konohen.konohen.view{
	import br.com.voraz.konohen.app.view.components.ApplicationView;
	import br.com.voraz.konohen.disciplines.model.DisciplinesProxy;
	import br.com.voraz.konohen.konohen.model.KohonenProxy;
	import br.com.voraz.konohen.notes.model.NotesProxy;
	import br.com.voraz.konohen.students.model.StudentsProxy;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class KonohenMediator extends Mediator implements IMediator{
		public static const NAME:String = "KonohenMediator";
		
		private var disciplinesProxy:DisciplinesProxy;
		private var studentProxy:StudentsProxy;
		private var notesProxy:NotesProxy;
		
		public function KonohenMediator(viewComponent:Object=null){
			super(NAME, viewComponent);
		}
		
		public function get applicationView():ApplicationView{
			return viewComponent as ApplicationView;
		}
		public function get index():Tcc{
			return applicationView.index
		}
		
		override public function onRegister():void{
			disciplinesProxy = new DisciplinesProxy();
			facade.registerProxy(disciplinesProxy);
			
			notesProxy = new NotesProxy();
			facade.registerProxy(notesProxy);
			
			studentProxy = new StudentsProxy();
			facade.registerProxy(studentProxy);
		}
		
		override public function listNotificationInterests():Array{
			return [
					KohonenProxy.ADDTEXT,
					NotesProxy.LIST_GOT,
					StudentsProxy.LIST_GOT
					];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case KohonenProxy.ADDTEXT:
					index.log.text += notification.getBody() as String; 
					trace(notification.getBody() as String);
					break;
				case NotesProxy.LIST_GOT:
					break;
				case StudentsProxy.LIST_GOT:
					treina();
					break;
			}
		}
		
		private function treina():void{
			facade.sendNotification(KohonenProxy.EXECUTE, StudentsProxy.students);
		}
		
	}
}