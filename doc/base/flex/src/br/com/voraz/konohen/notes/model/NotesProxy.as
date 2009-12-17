package br.com.voraz.konohen.notes.model{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class NotesProxy extends Proxy implements IProxy{
		public static const NAME:String = "NotesProxy";
		
		public static const LIST_GOT:String = "NotesProxy_list_got";
		public static var notes:Array;
		
		public function NotesProxy(data:Object=null){
			super(NAME, data);
		}
		
		override public function onRegister():void{
			var array:Array = NotesData.array;
			onGetNotes(array);
		}
		
		public function onGetNotes(array:Array):void{
			notes = array;
			facade.sendNotification(LIST_GOT, array);
		}
		
	}
}