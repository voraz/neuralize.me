package br.com.voraz.kohonen.train.controller{
	import br.com.voraz.flash.utils.Point;
	import br.com.voraz.flash.validators.DateValidator;
	import br.com.voraz.kohonen.vo.TrainObject;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class TrainCommand extends EventDispatcher{
		private var inputs:Array
		
		private var weights:Array
		
		private var trainingTimes:int = 5
		private var trainingTime:int = 0
		
		private var startRange:int = 10
		private var endRange:int = 1
		private var range:Number = startRange
		
		private var startAlpha:Number = 0.01
		private var endAlpha:Number = 0.001
		private var alpha:Number = startAlpha
		
		private var updateAt:int = 10
		
		private var startTime:Date
		private var endTime:Date
		
		private var print:TrainPrint
		
		public function TrainCommand(area:*){
			print = new TrainPrint(area)
			
		}
		
		public function start(weightXSize:int, weightYSize:int):void{
			createInputs(10, 3)
			createWeights(weightXSize, weightYSize, 3)
			print.area.addEventListener(Event.ENTER_FRAME, train)
			//train()
		}
		
		
		private function createInputs(xSize:int, ySize:int):void{
			inputs = new Array(xSize)
			for(var i:int=0; i<xSize; i++){
				inputs[i] = new Array(ySize)
				for (var j:int=0; j<ySize; j++){
					inputs[i][j] = new int(Math.random()*10)
				}
			}
			print.printMatrix(inputs, "Inputs")
		}
		private function createWeights(xSize:int, ySize:int, zSize:int):void{
			weights = new Array(xSize)
			for(var i:int=0; i<xSize; i++){
				weights[i] = new Array(ySize)
				for (var j:int=0; j<ySize; j++){
					weights[i][j] = new Array(zSize)
					for (var k:int=0; k<zSize; k++){
						weights[i][j][k] = new int(Math.random()*10)
					}
				}
			}
			print.printMatrix(weights, "Weights")
		}
		
		
		
		private function ajustRange(time:int):void{
			var factor:Number = (startRange-endRange)/trainingTimes
			if( time%int(1/factor)==0 && time>0){
				range--
			}
		}
		private function ajustAlpha(time:int):void{
			alpha -= (startAlpha-endAlpha)/trainingTimes
		}
		
		private function relativeAlpha(closerPoint:Point, rangePoint:Point):Number{
			return alpha/(indexDistance(closerPoint,rangePoint)+1)
		}
		
		//distance
		private function gaussianDistance(input:Array, point:Point):Number{
			var dist:Number = 0
			for (var k:int=0; k<input.length; k++){
				dist += Math.pow( input[k]-weights[point.x][point.y][k], 2 )
			}
			return Math.sqrt(dist)
		}
		private function indexDistance(closerPoint:Point, rangePoint:Point):Number{
			return Math.max(  Math.abs(closerPoint.x-rangePoint.x), Math.abs(closerPoint.y-rangePoint.y) )
		}
		private function inRange(closerPoint:Point, rangePoint:Point):Boolean{
			if( indexDistance(closerPoint, rangePoint) <= range){
				return true
			}else{
				return false
			}
		}
		
		
		private function findCloser(input:Array):Point{
			var closer:Point = new Point(0,0)
			for(var i:int=0; i<weights.length; i++){
				for(var j:int=0; j<weights[i].length; j++){
					if( weights[i][j]==input){
						closer = new Point(i,j)
						break
					}else if( gaussianDistance(input, new Point(i,j) ) < gaussianDistance(input,closer) ){
						closer = new Point(i,j)
					}
				}
			}
			return closer
		}
		
		private function learn(input:Array, closer:Point):void{
			var minI:int = Math.max( 0, closer.x-range )
			var maxI:int = Math.min( weights.length-1, closer.x+range )
			
			for(var i:int=minI; i<maxI; i++){
				var minJ:int = Math.max( 0, closer.y-range )
				var maxJ:int = Math.min( weights[i].lenght-1, closer.y+range )
				
				for(var j:int=minJ; j<maxJ; j++){
					for(var k:int=0; k<weights[i][j].lenght; k++){
						weights[i][j][k] = weights[i][j][k] + relativeAlpha(closer, new Point(i,j)) * weights[i][j][k]
					}
				}
			}
		}
		
		
		
		//*
		private function train(e:Event):void{
			if( trainingTime < trainingTimes){ 
				if(trainingTime==0){
					startTime = new Date()
					trace("Start at: ", DateValidator.formatHour(startTime) )
				}
				if(trainingTime%updateAt==0){
					dispatchEvent( new Event(Event.CHANGE) )
				}
				
				trainingTime++
			
				ajustRange(trainingTime)
				ajustAlpha(trainingTime)
				
				for(var weight:int=0; weight<weights.length; weight++){
					var input:Array = inputs[weight]
					var closer:Point = findCloser(input)
					
					//print.printStep(trainingTime, input, range, alpha)
					//print.printWeights(weights, closer, inRange)
					
					learn(input, closer)
					//trace(closer)
				}
			}else{
				endTime = new Date()
				trace("End at: ", DateValidator.formatHour(endTime) )
					
				print.area.removeEventListener(Event.ENTER_FRAME, train)
			}
		}
		
		public function actualPositions():Array{
			var positions:Array = new Array()
			
			for(var weight:int=0; weight<weights.length; weight++){
				var input:Array = inputs[weight]
				var closer:Point = findCloser(input)
				positions.push( new TrainObject(input, closer) )
			}
			
			return positions
		}
		
		/*/
		
		
		private function train():void{
			var startTime:Number = new Date().time
			
			for(var time:int=0; time<trainingTimes; time++){
				ajustRange(time)
				ajustAlpha(time)
				
				for(var weight:int=0; weight<weights.length; weight++){
					var input:Array = inputs[weight]
					var closer:Point = findCloser(input)
					
					trace("passo: "+time)
					print.printStep(time, input, range, alpha)
					print.printWeights(weights, closer, inRange)
					
					learn(input, closer)
					//trace(closer)
				}
			}
			trace("Total Time:", new Date().time-startTime ) 
		}
		
		*/
		
	}
}