package me.neuralize.datainsert.view.components.grid.lines.remove{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import me.neuralize.datainsert.view.components.grid.Datainsert_grid;
	
	import mx.events.FlexEvent;
	
	public class Datainsert_lines_remove extends Datainsert_lines_remove_base{
		
		public function Datainsert_lines_remove(){
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, start)
		}
		
		private function start(e:Event):void{
			btRemove.addEventListener(MouseEvent.CLICK, click)
		}
		
		private function click(e:Event):void{
			grid.removeLine( data )
		}
		
		private function get grid():Datainsert_grid{
			return this.owner as Datainsert_grid
		}
		
	}
}