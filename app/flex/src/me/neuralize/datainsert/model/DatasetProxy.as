package me.neuralize.datainsert.model{
	import br.com.voraz.flexLib.conection.HTTPServiceConnection;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class DatasetProxy extends Proxy implements IProxy{
		public static const NAME:String = "DatasetProxy"
		public static var instance:DatasetProxy
		
		public static const ON_LIST:String = NAME+"on_list"
		public static const ON_SHOW:String = NAME+"on_show"
		public static const ON_GET_OBJECTS:String = NAME+"on_get_objects"
		
		public static const ON_EDIT_COLUMN:String = NAME+"on_edit_column"	
		public static const ON_INSERT_COLUMN:String = NAME+"on_insert_column"
		
		public static const COLUMN_START:int = 2
			
		public function DatasetProxy(data:Object=null){
			super(NAME, data);
			facade.registerProxy(this)
		}
		public static function getInstance():DatasetProxy{
			if(instance==null)
				instance = new DatasetProxy()
			return instance
		}
		
		private function get conn():HTTPServiceConnection{
			return new HTTPServiceConnection("datasets")
		}
		
		public function list():void{
			conn.call("find_all", onList)
		}
		private function onList(array:Array):void{
			facade.sendNotification(ON_LIST, array)
		}
		
		public function show(id:String):void{
			//conn.call("find_by_id", onShow, null, {id:id})
		}
		private function onShow(vo:*):void{
			facade.sendNotification(ON_SHOW, vo)
		}
		
		public function getLinesAndColumns(id:String):void{
			conn.call("lines_and_columns", onGetObjects, null, {id:id})
		}
		private function onGetObjects(o:Object):void{
			facade.sendNotification(ON_GET_OBJECTS, o)
		}
		
	}
}