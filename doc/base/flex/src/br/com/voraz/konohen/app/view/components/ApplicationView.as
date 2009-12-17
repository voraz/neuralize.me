package br.com.voraz.konohen.app.view.components{
	import br.com.voraz.konohen.app.ApplicationFacade;
	
	import mx.core.Application;
	
	public class ApplicationView extends Application{
		public var index:Tcc;
		
		public function ApplicationView() {
			super();
		}
		public function set start(index:Tcc):void{
			trace("start "+index)
			this.index = index;
			ApplicationFacade.getInstance().sendNotification(ApplicationFacade.STARTUP, this);
		}
	}
}