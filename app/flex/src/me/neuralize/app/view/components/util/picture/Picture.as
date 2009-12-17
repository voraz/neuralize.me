package me.neuralize.app.view.components.util.picture{
	import br.com.voraz.flexLib.conection.HTTPServiceConnection;

	public class Picture extends PictureLoader{
		private var _type:String;
		public var vo:Object
		
		public static const GRID:String = "GRID"
		public static const SMALL:String = "SMALL"
		public static const THUMB:String = "THUMB"
			
		public function Picture(type:String){
			super(getSize(type)[0], getSize(type)[1]);
			_type = type
		}
		
		private function getSize(type:String):Array{
			switch(type){
				case THUMB:		return [365,215];		break;
				case SMALL:		return [120, 100];		break;
				case GRID:		return [50,  50];	 	break;
			}
			return null
		}
		
		private function geturl(vo:Object):String{
			switch(_type){
				case GRID:		return vo.grid;	 		break;
				case SMALL:		return vo.small;		break;
				case THUMB:		return vo.thumb;		break;
			}
			return null
		}
		
		public function show(vo:Object):Picture{
			if(vo!=null){
				this.vo = vo
				load( HTTPServiceConnection.urlBase + geturl(vo) )
			}
			return this
		}
		
		
		//shortcuts
		override public function get width() : Number{
			return super.width
		}
		override public function get height() : Number{
			return super.height
		}
	}
}