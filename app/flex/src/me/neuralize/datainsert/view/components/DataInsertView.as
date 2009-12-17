package me.neuralize.datainsert.view.components{
	
	import flash.events.Event;
	
	import me.neuralize.app.ApplicationFacade;
	import me.neuralize.datainsert.view.DataInsertMediator;
	import me.neuralize.datainsert.view.components.grid.controllers_grid.ControllerGrid;
	
	import mx.events.FlexEvent;

	public class DataInsertView extends DataInsertView_base{
		
		public function DataInsertView(){
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, onStart)
		}
		
		private function onStart(e:FlexEvent):void{
			mediator = new DataInsertMediator(this)
			ApplicationFacade.getInstance().registerMediator( mediator )
			controllersGrid.addEventListener(ControllerGrid.ADD_LINE, addLine)
		}
		
		
		private function addLine(e:Event):void{
			grid.addNewLine()
		}
		
	}
}