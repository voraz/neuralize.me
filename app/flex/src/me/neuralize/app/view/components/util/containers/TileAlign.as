package me.neuralize.app.view.components.util.containers{
	import me.neuralize.train.view.components.result.grid.points.Train_result_grid_points_default;

	public class TileAlign{
		
		public static function align( objects:Array, initialX:Number, initialY:Number, maxWidth:Number, maxHeight:Number, gap:Number=2):void{
			
			var cellArea:Number = maxWidth*maxHeight	
			var iconArea:Number =0
			for(var i:int=0; i<objects.length; i++){
				objects[i].finalScale = 1
				iconArea += (objects[i].width+gap)*(objects[i].height+gap)
			}
			
			var proportion:Number = Math.min( cellArea/iconArea, 1)
			for(i=0; i<objects.length; i++){
				objects[i].finalScale = Math.sqrt(proportion*objects[i].width*objects[i].height)/Math.max(objects[i].width,objects[i].height)
			}
			horizontalTile( objects, initialX, initialY, maxWidth, gap) 
		}
		
		private static function horizontalTile(objects:Array, initialX:Number, initialY:Number, maxWidth:Number, gap:Number=5):void{
			var currentLineHeight:Number = objects[0].height;
			var currentLineWidth:Number = objects[0].width;
			var linesHeight:Number = 0;
			
				objects[0].finalX = initialX 
				objects[0].finalY = initialY
				objects[0].tween()
					
				for(var i:int=1; i<objects.length; i++){
					try{
						var m:Train_result_grid_points_default = objects[i];
						if(currentLineWidth+m.width+gap < maxWidth){
							var mBefore:Train_result_grid_points_default = objects[i-1];
							m.finalY = mBefore.finalY;
							m.finalX = mBefore.finalX + mBefore.width + gap;
							currentLineHeight = Math.max(currentLineHeight, m.height);
							currentLineWidth += m.width+gap;
						}else{
							linesHeight+=currentLineHeight+gap;
							m.finalY = linesHeight+initialY;
							m.finalX = initialX;
							
							currentLineWidth = m.width;
							currentLineHeight = m.height;
						}
						m.tween()
					}catch(e:*){}
				}
		}
		
	}
}