package me.neuralize.vo{
	import br.com.voraz.flash.utils.Point;

	public class TrainObject{
		
		public var index:int
		public var data:Object
		public var pictures:Object
		public var point:Point
		
		public function TrainObject(o:Object){
			if(o!=null){
				index = o.index
				data = o.data.data
				pictures = o.data.pictures
			}
			point==null ? this.point=new Point(0,0) : this.point=point
		}
	}
}