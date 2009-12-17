package me.neuralize.train_list.view.components{
	import flash.events.Event;
	
	import me.neuralize.app.ApplicationFacade;
	import me.neuralize.app.model.WindowsProxy;
	import me.neuralize.train_list.view.TrainListMediator;
	
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;
	
	public class TrainListView extends TrainListView_base{
		
		public function TrainListView(){
			super()
			addEventListener(FlexEvent.CREATION_COMPLETE, start)
		}
		
		private function start(e:Event):void{
			mediator = new TrainListMediator(this)
			ApplicationFacade.getInstance().registerMediator( mediator )
			datagrid.addEventListener(ItemClickEvent.ITEM_CLICK, dataGridClick)
		}
		
		private function dataGridClick(e:Event):void{
			close()
			WindowsProxy.getInstance().open( WindowsProxy.TRAIN, datagrid.selectedItem.id)
		}
		
		
	}
}