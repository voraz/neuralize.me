package me.neuralize.datainsert.view.components.grid.lines.image{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import mx.events.FlexEvent;
	
	public class Datainsert_lines_image extends Datainsert_lines_image_base{
		private var file:FileReference
		private var fileFilterImage:FileFilter = new FileFilter("Images", "*.jpg;*.jpge;*.gif;*.png;*.svg") 
		
		public function Datainsert_lines_image(){
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, start)
		}
		
		private function start(e:Event):void{
			file = new FileReference()
			file.addEventListener(Event.SELECT, onSelect)
			file.addEventListener(Event.COMPLETE, onLoad)
			image.addEventListener(MouseEvent.CLICK, onBrowse)
		}
		
		private function onBrowse(e:Event):void{
			file.browse( [fileFilterImage] )
		}
		private function onSelect(e:Event):void{
			file.load()
		}
		private function onLoad(e:Event):void{
			image.loadBytes( file.data )
		}
		
		override public function set data(value:Object) : void{
			try{	
				image.show(value.pictures)
			}catch(e:*){
				
			}
		}
		
		
	}
}