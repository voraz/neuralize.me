package br.com.voraz.kohonen.train.view.components.container{
	import br.com.voraz.kohonen.vo.TrainObject;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class TrainingView_default extends MovieClip{
		
		public var vo:TrainObject
		
		private var txt:TextField = new TextField()
		private var sh:Shape = new Shape()
		
		public function TrainingView_default(vo:TrainObject){
			super();
			this.vo = vo
			
			txt.width = 20
			txt.autoSize = TextFieldAutoSize.CENTER
			txt.text = vo.vo.toString()
			addChild(txt)
			txt.x = -txt.width/2
			txt.y = -txt.height/2
			
			addChildAt(sh,0)
			with(sh.graphics){
				beginFill( Math.random()*999999*Math.random()*0xFF00DD, 0.3)
				drawEllipse(-10,-7,50,14)
				endFill()
			}
			sh.rotation = Math.random()*360
			
			this.cacheAsBitmap = sh.cacheAsBitmap = txt.cacheAsBitmap = true
		}
		
		
	}
}