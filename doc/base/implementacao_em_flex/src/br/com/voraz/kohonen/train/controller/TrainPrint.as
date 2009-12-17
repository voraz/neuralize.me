package br.com.voraz.kohonen.train.controller{
	import br.com.voraz.flash.utils.ColorUtil;
	import br.com.voraz.flash.utils.Point;
	
	public class TrainPrint{
		public var area:*
		private var htmlText:String = ""
		
		public function TrainPrint(area:*){
			this.area = area
		}
		
		public function printMatrix(matrix:Array, label:String=""):void{
			htmlText += "<br><b>"+label+"</b><br>"
			htmlText += matrixOut(matrix,2)
			update()
		}
		
		private function matrixOut(matrix:Array, tabs:int):String{
			var st:String = ""
			for each(var i:* in matrix){
				if( i[0] is Array){
					for each(var j:* in i){
						st+=arrayOut(j,tabs)
					}
				}else{
					st+=arrayOut(i,tabs)
				}
				st+="\n"
			}
			return st
		}
		
		private function printArray(array:Array, label:String=""):void{
			htmlText += "\n "+label
			htmlText += arrayOut(array, 2)
			update()
		}
		
		private function arrayOut(array:Array, tabs:int=0):String{
			var st:String = returnTabs(tabs)
			
			for each(var i:* in array){
				if(i is Array){
					st += arrayOut(i, tabs)+"\t"
				}else{
					st += i.toFixed(2).toString()+" "
				}
			}
			return st
		}
		
		private function tabulateString(st:String, tabs:int):String{
			var i:int = 0
			while(i<st.length && i!=-1){
				i = st.indexOf("\n", i)
				st = st.substr(0, i) +"#"+st.substr(i)
			}
			return st
		}
		
		private function returnTabs(tabs:int):String{
			var st:String = "" 
			for(var i:int=0; i<tabs; i++){
				st+="\t"
			}
			return st
		}
		private function colorizeArrayOut(color:Number, array:Array):String{
			return "<FONT COLOR='#"+ColorUtil.numberToString(color)+"'>"+arrayOut(array,1)+"</FONT>"
		}
		
		public function printStep(time:int, input:Array, range:int, alpha:Number):void{
			htmlText += "<br> <b>Passo: </b>"+time+"\t\t input: "+arrayOut(input)+"\t vizinhaça: "+range+"\t alpha: "+alpha+"<br>"
			update() 
			
		}
		
		public function printWeights(weights:Array,closer:Point, inRangeFunction:Function):void{
			var st:String = ""
			
			for(var i:int=0; i<weights.length; i++){
				for(var j:int=0; j<weights[i].length; j++){
					var color:Number
					if( i==closer.x && j==closer.y){
						color = 0x00FF00
					}else if( inRangeFunction(closer, new Point(i,j)) ){
						color = 0xFFFF00
					}else{
						color = 0xFFFFFF
					}
					st += colorizeArrayOut(color, weights[i][j])+"\t "
				}
				st += "\n"
			}
			htmlText+=st
			update()
		}
		
		public function printText(st:String):void{
			htmlText+=st
			update()
		}
		
		
		private function update():void{
			try{
				//area.htmlText = htmlText
			}catch(e:*){
				
			}
		}
		
		public function showText():void{
			area.htmlText = htmlText
		}
	}
}