package me.neuralize.train.view.components.result{
	import flash.events.Event;
	
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	
	public class Train_result_view_background extends UIComponent{
		private var _lines:Number = 0
		private var _columns:Number = 0
		private var _lineColor:Number = 0xCCCCCC
		
		private var _width:Number = 100
		private var _height:Number = 100
		
		public function Train_result_view_background(){
			super();
		}
		
		private function resize(e:Event=null):void{
			with(graphics){
				clear()
				lineStyle(1, _lineColor)
				drawRect(0,0,width,height)
			}
			for(var i:int=0; i<_lines; i++){
				graphics.moveTo(0, height/_lines*i)
				graphics.lineTo(width, height/_lines*i)
			}
			for(var j:int=0; j<_columns; j++){
				graphics.moveTo(width/_columns*j, 0)
				graphics.lineTo(width/_columns*j, height)
			}
		}
		
		public function set lines(value:*):void{
			_lines = int(value)
			resize()
		}
		public function set columns(value:*):void{
			_columns = int(value)
			resize()
		}
		public function set lineColor(value:int):void{
			_lineColor = value
			resize()
		}
		
		
		override public function set width(value:Number) : void{
			if(value!=_width){
				_width = value
				resize()
			}
		}		
		override public function get width() : Number{
			return _width
		}
		override public function set height(value:Number) : void{
			if(value!=_height){
				_height = value
				resize()
			}
		}		
		override public function get height() : Number{
			return _height
		}
		
	}
}