package me.neuralize.vo{
	[Bindable]
	[RemoteClass(alias="me.neuralize.vo.DatasetVO")]
	public class DatasetVO{
		
		public var id:String
		public var title:String
		public var description:String
		
		public var created_at:Date
		public var update_at:Date
		
		public function DatasetVO(o:Object=null){
			if(o!=null){
				id = o._id
				title = o.title
				description = o.description
					
				created_at = o.created_at
				update_at = o.update_at	
			}
		}
	}
}