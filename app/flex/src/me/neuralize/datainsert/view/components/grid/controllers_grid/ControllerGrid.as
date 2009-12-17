package me.neuralize.datainsert.view.components.grid.controllers_grid{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import me.neuralize.datainsert.view.components.grid.columns.popup.Datainsert_columns_popup;
	
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;

	public class ControllerGrid extends ControllerGrid_base{
		public static const ADD_LINE:String = "addLineController"
			
		public var data:Object
		
		public function ControllerGrid(){
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, onStart)
		}
		
		private function onStart(e:FlexEvent):void{
			btAddColumn.addEventListener(MouseEvent.CLICK, addPopColumn)
			btAddLine.addEventListener(MouseEvent.CLICK, addLine)
		}
		
		private function addLine(e:MouseEvent):void{
			dispatchEvent(new Event(ADD_LINE))
		}
		
		private function addPopColumn(e:MouseEvent):void{
			PopUpManager.addPopUp(Datainsert_columns_popup.getInstance(), FlexGlobals.topLevelApplication as Sprite, true)
			PopUpManager.centerPopUp(Datainsert_columns_popup.getInstance())
		}
		
	}
}