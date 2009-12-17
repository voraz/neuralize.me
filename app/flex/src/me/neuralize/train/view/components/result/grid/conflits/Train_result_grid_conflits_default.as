package me.neuralize.train.view.components.result.grid.conflits{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import me.neuralize.app.ApplicationFacade;
	import me.neuralize.train.model.TrainProxy;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	public class Train_result_grid_conflits_default extends UIComponent{
		private var _vo:Array
		
		private var ball:Shape = new Shape()
		private var images:Train_result_grid_conflits_default_images = new Train_result_grid_conflits_default_images()
		
		private var _width:Number
		private var _height:Number
			
		public function Train_result_grid_conflits_default(vo:Array, cellWidth:Number=10, cellHeight:Number=10){
			super();
			this.vo = vo
			_width = cellWidth
			_height = cellHeight
				
			addEventListener(FlexEvent.CREATION_COMPLETE, start)
		}
		private function start(e:FlexEvent):void{
			addChild(images)
			addChild(ball)
			
			drawBall()
			setButton()
		}
		
		private function drawBall():void{
			var radius:Number = Math.min(_width, _height, 10 )
			with(ball.graphics){
				clear()
				beginFill(0x000000, 0.1)
				drawEllipse(0, 0, radius, radius )
				endFill()
			}
		}
		
		private function setButton():void{
			addEventListener(MouseEvent.CLICK, click)
		}
		
		private function click(e:Event):void{
			ApplicationFacade.getInstance().sendNotification(TrainProxy.CONFLIT_ITEM_CLICK, vo[0] )
		}
			
		
		public function set vo(value:Array):void{
			_vo = value
			images.show(value)
		}
		public function get vo():Array{
			return _vo
		}
		
		//sizing...
		private function align(e:Event=null):void{
			drawBall()
			ball.x = _width/2-ball.width/2
			ball.y = _height/2-ball.height/2
				
			images.width = _width
			images.height = _height
		}
		override public function set width(value:Number) : void{
			if(_width!=value){
				_width = value
				align()
			}
		}
		override public function set height(value:Number) : void{
			if(_height!=value){
				_height = value
				align()
			}
		}
	}
}