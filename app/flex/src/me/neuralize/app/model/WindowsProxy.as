package me.neuralize.app.model{
	import me.neuralize.app.ApplicationFacade;
	import me.neuralize.app.view.components.util.containers.DefaultTitleWindow;
	import me.neuralize.datainsert.view.components.DataInsertView;
	import me.neuralize.train.view.components.TrainView;
	import me.neuralize.train_list.view.components.TrainListView;
	
	import mx.events.FlexEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class WindowsProxy extends Proxy implements IProxy{
		public static const NAME:String = "WindowsProxy"
		public static var instance:WindowsProxy
		
		public static const DATAINSERT:String = "datainsert"
		public static const DATAINSERT_LIST:String = "datainsert_list"
		public static const TRAIN:String = "train"
		public static const TRAIN_LIST:String = "train_list"
			
		public static const OPENED:String = NAME+"opened"
			
		public function WindowsProxy(data:Object=null){
			super(NAME, data);
			facade.registerProxy(this)
		}
		public static function getInstance():WindowsProxy{
			if(instance==null)
				instance = new WindowsProxy()
			return instance
		}
		
		public function open(name:String, body:Object=null):void{
			var ClassOpen:Class
			switch(name){
				case DATAINSERT: 	ClassOpen=DataInsertView;		break
				case TRAIN:			ClassOpen=TrainView;			break
				case TRAIN_LIST:	ClassOpen=TrainListView;		break
			}
			if(ClassOpen!=null){
				var window:DefaultTitleWindow = new ClassOpen()
				window.addEventListener(FlexEvent.CREATION_COMPLETE, function():void{facade.sendNotification( OPENED, {window:window, data:body} )} )
				ApplicationFacade.getInstance().app.container.addElement( window )
			}
		}
		
	}
}