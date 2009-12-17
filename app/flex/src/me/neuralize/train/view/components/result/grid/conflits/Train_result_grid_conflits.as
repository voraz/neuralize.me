package me.neuralize.train.view.components.result.grid.conflits{
	import br.com.voraz.flash.utils.Point;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import mx.core.UIComponent;
	
	public class Train_result_grid_conflits extends UIComponent{
		
		private var relativePoint:Function
		
		public function Train_result_grid_conflits(relativePoint:Function){
			super();
			this.relativePoint = relativePoint
		}
		
		public function update(colisions:Array, cellWidth:Number, cellHeight:Number):void{
			removeUnused(colisions)
			
			for each(var o:Array in colisions){
				var exist:Boolean = false
				for(var i:int=0; i<numChildren; i++){
					var icon:Train_result_grid_conflits_default = getChildAt(i) as Train_result_grid_conflits_default
					if( icon.vo[0].x==o[0].x && icon.vo[0].y==o[0].y){
						icon.vo = o
						exist = true
						break
					} 
				}
				if(exist==false){
					icon = new Train_result_grid_conflits_default(o)
					addChild(icon)
					icon.alpha = 0
				}
			}
			align(cellWidth, cellHeight)
		}
		
		private function removeUnused(colisions:Array):void{
			var toRemove:Array = []
			for(var i:int=0; i<numChildren; i++){
				var icon:Train_result_grid_conflits_default = getChildAt(i) as Train_result_grid_conflits_default
				var exist:Boolean = false
				for each(var o:Array in colisions){	
					if( icon.vo[0].x==o[0].x && icon.vo[0].y==o[0].y){
						exist = true
						break
					}
				}
				if(exist==false)
					toRemove.push(icon)
			}
			for(i=0; i<toRemove.length; i++){
				removeChild(toRemove[i])
			}
		}
		
		public function align(cellWidth:Number, cellHeight:Number):void{
			for(var i:int=0; i<numChildren; i++){
				var icon:Train_result_grid_conflits_default = getChildAt(i) as Train_result_grid_conflits_default
				
				if(icon!=null){
					var point:Point = relativePoint(icon.vo[0].x, icon.vo[0].y)
					if(icon.alpha!=1)
						TweenLite.to( icon, 1, {alpha:1, ease:Quad.easeOut} )
					icon.x = point.x
					icon.y = point.y
					icon.width = cellWidth
					icon.height = cellHeight
				} 
			}
		}
		
	}
}