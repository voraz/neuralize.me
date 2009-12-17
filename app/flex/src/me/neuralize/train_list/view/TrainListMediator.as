package me.neuralize.train_list.view{
	import me.neuralize.train.model.TrainProxy;
	import me.neuralize.train_list.view.components.TrainListView;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TrainListMediator extends Mediator implements IMediator{
		public static const NAME:String = "TrainListMediator"
			
		public function TrainListMediator(viewComponent:Object=null){
			super(NAME, viewComponent);
		}
		override public function onRegister() : void{
			TrainProxy.getInstance().list()
		}
		
		override public function listNotificationInterests() : Array{
			return [ 
					TrainProxy.ON_LIST
					]
		}
		override public function handleNotification(notification:INotification) : void{
			switch(notification.getName()){
				case TrainProxy.ON_LIST:
					list.datagrid.dataProvider = notification.getBody() as Array
					break
			}
		}
		
		private function get list():TrainListView{
			return viewComponent as TrainListView
		}
	}
}