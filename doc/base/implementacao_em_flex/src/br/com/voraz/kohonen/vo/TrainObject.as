package br.com.voraz.kohonen.vo{
	import br.com.voraz.flash.utils.Point;

	public class TrainObject{
		
		public var vo:Object
		public var point:Point
		
		public function TrainObject(vo:Object=null, point:Point=null){
			vo==null ? this.vo=new Object() : this.vo=vo
			point==null ? this.point=new Point(0,0) : this.point=point
		}
	}
}