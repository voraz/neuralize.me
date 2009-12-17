package br.com.voraz.konohen.app.controller{
	import br.com.voraz.konohen.app.view.ApplicationMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class ApplicationCommand extends SimpleCommand{
		
		override public function execute(notification:INotification):void{
			facade.registerMediator( new ApplicationMediator(notification.getBody()));
		}
		
	}
}