package me.neuralize.train.view.components.result.grid.points{
	import br.com.voraz.flash.utils.Point;
	
	import me.neuralize.app.view.components.util.containers.TileAlign;
	import me.neuralize.vo.TrainObject;
	
	import mx.core.UIComponent;
	
	public class Train_result_grid_points extends UIComponent{
		private var relativePoint:Function
		
		private var _collisions:Array
		private var _cellWidth:Number = 10
		private var _cellHeight:Number = 10
		
		public function Train_result_grid_points(relativePoint:Function){
			super();
			this.relativePoint = relativePoint
		}
		
		public function addObjects(positions:Array, width:Number, height:Number):void{
			while(numChildren>0){
				removeChildAt(0)
			}
			
			for each(var o:Object in positions){
				var icon:Train_result_grid_points_default = new Train_result_grid_points_default(o)
				addChild(icon)
				startAlign(width, height)
			}
		}
		public function update(positions:Array, collisions:Array, cellWidth:Number, cellHeight:Number):void{
			_collisions = collisions
			_cellWidth = cellWidth
			_cellHeight = cellHeight
				
			if(numChildren>0){
				for(var i:int=0; i<numChildren; i++){
					var icon:Train_result_grid_points_default = getChildAt(i) as Train_result_grid_points_default
					
					for each(var new_object:Object in positions){
						if(icon.vo.index == new_object.index){
							icon.vo.point.x = new_object.x
							icon.vo.point.y = new_object.y
							break
						}
					}
				}
				updateCollisions( collisions )
				align()
			}
		}
		private function updateCollisions(tmpColisions:Array):void{
			var colisions:Array = []
			for(var i:int=0; i<tmpColisions.length; i++){
				for(var j:int=0; j<tmpColisions[i].length; j++){
					if( tmpColisions[i][j]!=null )
						colisions.push( tmpColisions[i][j] )
				}
			}
			
			for(i=0; i<numChildren; i++){
				var icon:Train_result_grid_points_default = getChildAt(i) as Train_result_grid_points_default
				var collided:Boolean = false
				for each(var object:Object in colisions){
					if(icon.vo.index == object.index){
						collided = true
						break
					}
				}
				icon.collided = collided
			}
		}
		
		
		public function align(withTween:Boolean=true, cellWidth:Number=0, cellHeight:Number=0):void{
			if(cellWidth!=0) _cellWidth = cellWidth
			if(cellHeight!=0) _cellHeight = cellHeight
				
			for(var i:int=0; i<numChildren; i++){
				var icon:Train_result_grid_points_default = getChildAt(i) as Train_result_grid_points_default
					
				if(icon!=null){
					if(icon.collided==false){
						var point:Point = relativePoint(icon.vo.point.x, icon.vo.point.y)
						
						//if(withTween){
						TileAlign.align( [icon], point.x, point.y, _cellWidth, _cellHeight)
							//icon.finalX = point.x
							//icon.finalY = point.y
							//icon.finalScale = 1
							//icon.tween()
						//}else{
						//	icon.x = point.x
						//	icon.y = point.y
						//}
					}
				} 
			}
			alignCollisions(withTween)
		}
		
		private function alignCollisions(withTween:Boolean=true):void{
			for each(var collision:Array in _collisions){
				
				var firstPoint:Point = relativePoint( collision[0].x,collision[0].y )
				var icons:Array = getConflitsIcons( collision[0].x,collision[0].y )
				for(var i:int=0; i<icons.length; i++){
					//icons[i].finalScale = 0.35
				}
				TileAlign.align( icons, firstPoint.x, firstPoint.y, _cellWidth, _cellHeight)
			}
		}
		
		private function iconByTrainObject(vo:TrainObject):Train_result_grid_points_default{
			for(var i:int=0; i<numChildren; i++){
				var icon:Train_result_grid_points_default = getChildAt(i) as Train_result_grid_points_default
				if(icon.vo.index == vo.index){
					return icon
					break
				}
			}
			return null
		}
		
		private function startAlign(_width:Number, _height:Number):void{
			var itens:Array = new Array()
			for(var i:int=0; i<numChildren; i++){
				itens.push(getChildAt(i))
			}
			TileAlign.align( itens, 0, 0, _width, _height)
		}
		
		public function changeLabelField(index:int):void{
			for(var i:int=0; i<numChildren; i++){
				var icon:Train_result_grid_points_default = getChildAt(i) as Train_result_grid_points_default
				icon.changeLabelField(index)
			}
		}
		
		public function getConflitsVos(x:int, y:int):Array{
			var conflits:Array = []
			for(var i:int=0; i<numChildren; i++){
				var icon:Train_result_grid_points_default = getChildAt(i) as Train_result_grid_points_default
				if(icon.vo.point.x==x && icon.vo.point.y==y)
					conflits.push(icon.vo)
			}
			return conflits
		}

		public function getConflitsIcons(x:int, y:int):Array{
			var conflits:Array = []
			for(var i:int=0; i<numChildren; i++){
				var icon:Train_result_grid_points_default = getChildAt(i) as Train_result_grid_points_default
				if(icon.vo.point.x==x && icon.vo.point.y==y)
					conflits.push(icon)
			}
			return conflits
		}
	}
}