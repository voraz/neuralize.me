package br.com.voraz.kohonen.vo{
	import br.com.voraz.flash.utils.Point;

	public class TrainObject{
		
		public var id:int
		public var vo:Array
		public var point:Point
		
		public function TrainObject(id:int, vo:Array=null, point:Point=null){
			this.id = id
			this.vo = vo
			point==null ? this.point=new Point(0,0) : this.point=point
		}
	}
}