package me.neuralize.datainsert.view{
	import me.neuralize.datainsert.model.DatasetProxy;
	import me.neuralize.datainsert.view.components.DataInsertView;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class DataInsertMediator extends Mediator implements IMediator{
		public static const NAME:String = "DataInsertMediator"
		
		public function DataInsertMediator(viewComponent:Object=null){
			super(NAME, viewComponent);
		}
		override public function onRegister() : void{
			DatasetProxy.getInstance().show("")
		}
		
		override public function listNotificationInterests() : Array{
			return [
				DatasetProxy.ON_INSERT_COLUMN,
				DatasetProxy.ON_EDIT_COLUMN,
				DatasetProxy.ON_SHOW
			]
		}
		override public function handleNotification(notification:INotification) : void{
			switch(notification.getName()){
				case DatasetProxy.ON_INSERT_COLUMN:
					dataInsert.grid.addNewCollumn(notification.getBody())
					break
				case DatasetProxy.ON_EDIT_COLUMN:
					dataInsert.grid.onEditCollumn(notification.getBody().index, notification.getBody().data)
					break
				case DatasetProxy.ON_SHOW:
					dataInsert.grid.show(notification.getBody())
					break;
			}
		}
		
		private function get dataInsert():DataInsertView{
			return viewComponent as DataInsertView
		}
	}
}