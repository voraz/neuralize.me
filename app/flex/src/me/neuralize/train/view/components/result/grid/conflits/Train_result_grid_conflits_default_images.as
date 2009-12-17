package me.neuralize.train.view.components.result.grid.conflits{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import me.neuralize.app.view.components.util.picture.PictureGrid;
	import me.neuralize.train.model.TrainProxy;
	
	import mx.core.UIComponent;
	
	public class Train_result_grid_conflits_default_images extends UIComponent{
		
		private var _width:Number
		private var _height:Number
		private var _verticalGap:Number = 2
		private var _horizontalGap:Number = 2
		
		public function Train_result_grid_conflits_default_images(){
			super();
		}
		
		public function show(value:Array):void{
			var vos:Array = getVos(value)
			removeUnused(vos)
			
			for each(var o:Object in vos){
				var exist:Boolean = false
				for(var i:int=0; i<numChildren; i++){
					var icon:PictureGrid = getChildAt(i) as PictureGrid
					if( icon.vo == o.data.pictures){
						exist = true
						break
					} 
				}
				if(exist==false){
					icon = new PictureGrid()
					icon.show(o.data.pictures)
					addChild(icon)
				}
			}
			align()
		}
		
		private function removeUnused(value:Array):void{
			var toRemove:Array = []
			for(var i:int=0; i<numChildren; i++){
				var icon:PictureGrid = getChildAt(i) as PictureGrid
				var exist:Boolean = false
				for each(var o:Object in value){	
					if( icon.vo == o.data.pictures){
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
		
		
		private function getVos(colisions:Array):Array{
			var array:Array = []
			for( var i:int=0; i<colisions.length; i++){
				array.push( TrainProxy.getInstance().getVoByIndex(colisions[i].index) )
			}
			return array
		}
		
		
		private function align(e:Event=null):void{
			var currentLineHeight:Number = 0;
			var currentLineWidth:Number = 0;
			var linesHeight:Number = 0;
			
			if(numChildren>0){
				getChildAt(0).x = 0 
				getChildAt(0).y = 0
				
				getChildAt(0).scaleX = getChildAt(0).scaleY = 0.5
				
				for(var i:int=1; i<numChildren; i++){
					try{
						var m:DisplayObject = getChildAt(i);
						m.scaleX = m.scaleY = 0.5
						if(currentLineWidth+m.width < _width){
							var mBefore:DisplayObject = getChildAt(i-1);
							m.y = mBefore.y;
							m.x = mBefore.x + mBefore.width/2 + _horizontalGap;
							currentLineHeight = Math.max(currentLineHeight, m.height/2);
							currentLineWidth = m.x + m.width;
						}else{
							linesHeight+=currentLineHeight+_verticalGap;
							m.y = linesHeight;
							m.x = 0;
							
							currentLineWidth = 0;
							currentLineHeight = 0;
						}
					}catch(e:*){}
				}
				_height = linesHeight+currentLineHeight;
			}
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