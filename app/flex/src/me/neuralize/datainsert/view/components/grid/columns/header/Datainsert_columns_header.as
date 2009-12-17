package me.neuralize.datainsert.view.components.grid.columns.header{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import me.neuralize.datainsert.view.components.grid.Datainsert_grid;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;

	public class Datainsert_columns_header extends Datainsert_columns_header_base{
		private var leftButton:Boolean = new Boolean(false)
		
		public function Datainsert_columns_header(){
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, started)
		}
		
		private function started(e:FlexEvent):void{
			btEdit.addEventListener(MouseEvent.CLICK, editColumn)
			btRemove.addEventListener(MouseEvent.CLICK, removeColumn)
			cbIncluded.addEventListener(Event.CHANGE, changeIncluded)
		}
		
		private function editColumn(e:MouseEvent):void{
			grid.editCollumn(getIndex())
		}
		
		private function removeColumn(e:MouseEvent):void{
			Alert.show("Are you sure?", "Remove column confirmation", Alert.YES | Alert.NO, FlexGlobals.topLevelApplication as Sprite, alertListener )
		}
		private function alertListener(event:CloseEvent):void{
			if(event.detail==Alert.YES)
				grid.removeColum( getIndex() )
		}
		
		
		override public function set data(value:Object) : void{
			if(super.data!=value){
				super.data = value
				if(getData()!=null){
					txtLabel.text = getData().title
					cbIncluded.selected = getData().included
				}
			}
		}
		
		private function getData():Object{
			return grid.columnsProvider[getIndex()]
		}
		private function getIndex():int{
			for(var i:int=0; i<grid.arrayColumns.length; i++)
				if( grid.arrayColumns[i]==data)
					return i

			return -1
		}
		
		private function get grid():Datainsert_grid{
			return this.owner as Datainsert_grid
		}
		
		private function changeIncluded(e:Event):void{
			grid.columnsProvider[getIndex()].included = cbIncluded.selected
		}
		
	}
}