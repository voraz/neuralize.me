package br.com.voraz.kohonen.train.view.components.container{
	import br.com.voraz.flash.utils.Point;
	import br.com.voraz.kohonen.vo.TrainObject;
	
	import flash.display.MovieClip;
	
	import gs.TweenLite;
	import gs.easing.Linear;

	public class TrainingView_container extends MovieClip{
		private var _width:Number = 200
		private var _height:Number = 200
		
		private var weightsSizeX:int
		private var weightsSizeY:int
		
		private var positions:Array
		
		public function TrainingView_container(weightsSizeX:int, weightsSizeY:int, width:Number=200, height:Number=200){
			super();
			this.weightsSizeX = weightsSizeX
			this.weightsSizeY = weightsSizeY
			this.width = width
			this.height = height
		}
		
		public function setPositions(positions:Array):void{
			this.positions = positions
			for each(var o:TrainObject in positions){
				var icon:TrainingView_default = new TrainingView_default(o)
				addChild(icon)
			}
		}
		
		public function ajustPositions(positions:Array):void{
			if(positions!=null){
				this.positions = positions
				for each(var o:TrainObject in positions){
					var icon:TrainingView_default = iconByTrainObject(o)
					if(icon!=null){
						icon.vo = o
						
						TweenLite.killTweensOf(icon)
						var point:Point = relativePoint(o.point)
						TweenLite.to( icon, 1.5, {x:point.x, y:point.y, ease:Linear.easeNone} )
					} 
				}
			}
		}
		
		
		
		private function iconByTrainObject(vo:TrainObject):TrainingView_default{
			for(var i:int=0; i<numChildren; i++){
				var icon:TrainingView_default = getChildAt(i) as TrainingView_default
				if(icon.vo.id == vo.id){
					return icon
				}
			}
			return null
		}
		
		//
		private function relativePoint(point:Point):Point{
			return new Point( point.x/weightsSizeX*_width, point.y/weightsSizeY*_height)
		}
		override public function set width(value:Number) : void{
			_width = value
			ajustPositions(this.positions)
			drawBg()
		}
		override public function set height(value:Number) : void{
			_height = value
			ajustPositions(this.positions)
			drawBg()
		}
		private function drawBg():void{
			with(graphics){
				clear()
				lineStyle(1)
				beginFill(0xFFFFFF)
				drawRect(0,0,_width, _height)
				endFill()
			}
		}
	}
}