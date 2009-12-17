package me.neuralize.datainsert.view.components.grid.lines.edit{
	import flash.events.Event;
	
	import me.neuralize.datainsert.model.DatasetProxy;
	import me.neuralize.datainsert.view.components.grid.Datainsert_grid;
	
	import mx.events.FlexEvent;
	
	public class Datainsert_lines_edit extends Datainsert_lines_edit_base {
		
		public function Datainsert_lines_edit(){
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, start)
		}
		
		private function start(e:Event):void{
			
		}
		
		override public function set data(value:Object) : void{
			if(value!=data){
				super.data = value
				
				try{		
					text = value.data[columnIndex]
				}catch(e:*){
					
				}
			}
		}
		
		
		private function get columnIndex():int{
			for( var i:int=0; i<grid.arrayColumns.length; i++){
				if( grid.arrayColumns[i] == grid.columns[listData.columnIndex] ){
					return i-DatasetProxy.COLUMN_START
					break
				}
			}
			return -1
		}
		private function get rowIndex():int{
			return listData.rowIndex
		}
		
		private function get grid():Datainsert_grid{
			return this.owner as Datainsert_grid
		}
		
	}
}