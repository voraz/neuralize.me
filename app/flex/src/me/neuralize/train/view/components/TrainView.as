package me.neuralize.train.view.components{
	import flash.events.Event;
	
	import me.neuralize.app.ApplicationFacade;
	import me.neuralize.train.view.TrainMediator;
	
	import mx.events.FlexEvent;

	public class TrainView extends Train_view{
		
		public function TrainView(){
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, creationComplete)
		}
		
		private function creationComplete(e:Event):void{
			mediator =  new TrainMediator(this)
			ApplicationFacade.getInstance().registerMediator( mediator )
		}
		
	}
}