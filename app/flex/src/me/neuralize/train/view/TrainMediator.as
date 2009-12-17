package me.neuralize.train.view{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import me.neuralize.app.model.WindowsProxy;
	import me.neuralize.datainsert.model.DatasetProxy;
	import me.neuralize.train.model.TrainProxy;
	import me.neuralize.train.view.components.TrainView;
	import me.neuralize.vo.TrainObject;
	
	import mx.controls.Alert;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TrainMediator extends Mediator implements IMediator{
		public static const NAME:String = "TrainMediator"
			
		public function TrainMediator(viewComponent:Object=null){
			super(NAME, viewComponent);
		}
		
		override public function onRegister() : void{
			DatasetProxy.getInstance().list()
			train.bar.buttonTrain.addEventListener(MouseEvent.CLICK, startTrain)
		} 
		
		override public function listNotificationInterests() : Array{
			return [
					DatasetProxy.ON_GET_OBJECTS,
					DatasetProxy.ON_LIST,
					TrainProxy.UPDATED,
					TrainProxy.COMPLETE,
					TrainProxy.SHOW_STEP,
					TrainProxy.GRID_ITEM_CLICK,
					TrainProxy.GRID_ITEM_REMOVE,
					TrainProxy.CONFLIT_ITEM_CLICK,
					TrainProxy.ON_SHOW,
					WindowsProxy.OPENED
					]
		}
		override public function handleNotification(notification:INotification) : void{
			switch(notification.getName()){
				case DatasetProxy.ON_LIST:
					train.bar.list.dataProvider = notification.getBody() as Array
					break
				case TrainProxy.ON_SHOW:
					train.result.grid.addObjects( notification.getBody().lines )
					train.labelFieldList.dataProvider = notification.getBody().columns
					train.comparative.setColumns( notification.getBody().columns )
					train.bar.parameters = notification.getBody().train
					train.updateLinesAndColumns()
					train.setTimelineMax( TrainProxy.getInstance().results.length-1 )
					train.onStartTrain()
					break
				case DatasetProxy.ON_GET_OBJECTS:
					train.result.grid.addObjects( notification.getBody().lines )
					train.labelFieldList.dataProvider = notification.getBody().columns
					train.comparative.setColumns( notification.getBody().columns )
					TrainProxy.getInstance().start(train.bar.parameters, notification.getBody().lines )
					break
				case TrainProxy.COMPLETE:
					Alert.show("Treinamento finalizado", "", 4, train)
					train.setTimelineMax( TrainProxy.getInstance().results.length-1 ) 
					break
				case TrainProxy.UPDATED:
					train.setTimelineMax( TrainProxy.getInstance().results.length-1 ) 
					break
				case TrainProxy.SHOW_STEP:
					train.result.grid.updatePositions( TrainProxy.getInstance().results[notification.getBody() as int] )
					break
				case TrainProxy.GRID_ITEM_CLICK:
					train.comparative.addItem( notification.getBody() as TrainObject)
					break
				case TrainProxy.CONFLIT_ITEM_CLICK:
					train.comparative.addItens( train.result.grid.getColisionsVos(notification.getBody().x, notification.getBody().y) )
					break
				case TrainProxy.GRID_ITEM_REMOVE:
					train.comparative.removeItem( notification.getBody() as Array)
					break
				case WindowsProxy.OPENED:
					if(notification.getBody().window==train){
						if(notification.getBody().data!=null){
							TrainProxy.getInstance().show(notification.getBody().data) 
						}
					}
					break
			}
		}
		
		
		
		
		private function startTrain(e:Event=null):void{
			train.onStartTrain()
			DatasetProxy.getInstance().getLinesAndColumns(train.bar.list.selectedItem.id)
		}
		
		private function get train():TrainView{
			return viewComponent as TrainView
		}
		
	}
}