package br.com.voraz.kohonen.train.view.components{
	import br.com.voraz.flash.utils.Base;
	import br.com.voraz.kohonen.train.controller.TrainCommand;
	import br.com.voraz.kohonen.vo.TrainObject;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;

	public class TrainingViewMc extends MovieClip{
		private var txt:TextField
		
		private var train:TrainCommand
		
		public function TrainingViewMc(){
			super();
			
			Base.stage = stage
			stage.addEventListener(Event.RESIZE, resize)
			
			txt = this["mc_txt"]
			
			train = new TrainCommand(txt)
			train.addEventListener(Event.CHANGE, change)
			train.start()
			
			resize()
		}
		
		private function change(e:Event):void{
			for each(var o:TrainObject in train.actualPositions()){
				trace(o.vo,null ,o.point.x, o.point.y)
			}
		}
		
		
		private function resize(e:Event=null):void{
			//txt.width = stage.stageWidth
			//txt.height = stage.stageHeight
		}
		
		
		
		
	}
}