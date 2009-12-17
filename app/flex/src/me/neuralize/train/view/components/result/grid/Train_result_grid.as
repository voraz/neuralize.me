package me.neuralize.train.view.components.result.grid{
	import br.com.voraz.flash.utils.Point;
	
	import me.neuralize.train.view.components.result.grid.conflits.Train_result_grid_conflits;
	import me.neuralize.train.view.components.result.grid.points.Train_result_grid_points;
	
	import mx.core.UIComponent;
	
	public class Train_result_grid extends UIComponent{
		private var lines:int
		private var columns:int
		
		private var _width:Number
		private var _height:Number
		
		private var points:Train_result_grid_points

		public function Train_result_grid(){
			super();
			points = new Train_result_grid_points(relativePoint)
			addChild(points)
		}
		
		public function setWeightsSize(lines:int, columns:int):void{
			this.lines = lines
			this.columns = columns
		}
		
		public function relativePoint(x:int, y:int):Point{
			return new Point( x/columns*_width, y/lines*_height)
		}
		
		public function addObjects(positions:Array):void{
			points.addObjects( positions, _width, _height )
		}
		public function updatePositions(positions:Array):void{
			if(positions!=null){
				var colisions:Array = getColisions( positions )
				points.update(positions, colisions, cellWidth, cellHeight)
			}
		}
		
		public function changeLabelField(index:int):void{
			points.changeLabelField(index)
		}
		
		
		private function getColisions(tmpPositions:Array):Array{
			var positions:Array = tmpPositions.slice()
			var colisions:Array = new Array()
			
			var i:int=0;
			while(i<positions.length){
				var currentColisions:Array = []
				
				var j:int = 0
				while(j<positions.length){
					var removeJ:Boolean = false
					try{
						if( positions[i].x==positions[j].x && positions[i].y==positions[j].y && positions[i].index!=positions[j].index && positions[j]!=undefined && positions[j]!=null ){
							currentColisions.push( positions[j] )
							positions.splice(j, 1)
							removeJ = true
						}
					}catch(e:*){}
					
					if(removeJ){
						if(j>0)
							j--
					}else{
						j++
					}
				}
				if( currentColisions.length>0){
					currentColisions.push( positions[i] )
					colisions.push( currentColisions )
					positions.splice(i, 1)
					if(i>0)
						i--
				}else{
					i++
				}
			}
			return colisions
		}
		
		private function recursiveRemove():void{
			
		}
		
		public function getColisionsVos(x:int, y:int):Array{
			return points.getConflitsVos(x,y)
		}
		
		
		//sizing...
		public function align(withTween:Boolean=true):void{
			points.align(withTween, cellWidth, cellHeight)
		}
		override public function set width(value:Number) : void{
			if(value!=_width){
				_width = value
				align(false)
			}
		}		
		override public function get width() : Number{
			return _width
		}
		override public function set height(value:Number) : void{
			if(value!=_height){
				_height = value
				align(false)
			}
		}		
		override public function get height() : Number{
			return _height
		}
		
		private function get cellWidth():Number{
			return _width/columns
		}
		private function get cellHeight():Number{
			return _height/lines
		}
	}
}