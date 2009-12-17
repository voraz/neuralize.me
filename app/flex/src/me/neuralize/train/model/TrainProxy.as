package me.neuralize.train.model{
	import br.com.voraz.flash.utils.Firebug;
	import br.com.voraz.flexLib.conection.HTTPServiceConnection;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class TrainProxy extends Proxy implements IProxy{
		public static const NAME:String = "TrainProxy"
		public static var instance:TrainProxy
		
		public static const UPDATED:String = NAME+"updated"
		public static const COMPLETE:String = NAME+"complete"
		public static const GRID_ITEM_CLICK:String = NAME+"grid_item_click"
		public static const GRID_ITEM_REMOVE:String = NAME+"grid_item_remove"
		public static const CONFLIT_ITEM_CLICK:String = NAME+"conflit_item_click"
		public static const SHOW_STEP:String = NAME+"show_step"	
		public static const ON_SHOW:String = NAME+"on_show"
		public static const ON_LIST:String = NAME+"on_list"

		private var train_id:String
		public var lines:Array
		public var results:Array
		
		private var timer:Timer
		
		public function TrainProxy(data:Object=null){
			super(NAME, data);
			facade.registerProxy(this)
		}
		public static function getInstance():TrainProxy{
			if(instance==null)
				instance = new TrainProxy()
			return instance
		}
		
		private function get conn():HTTPServiceConnection{
			return new HTTPServiceConnection("trains")
		}
		
		
		public function start(params:Object, lines:Array):void{
			this.lines = lines
			timer = new Timer(params.update_at*1000)
			results = []
			conn.call("start",onStart,null, params)
		}
		private function onStart(o:Object):void{
			train_id = o.id
			timer.addEventListener(TimerEvent.TIMER, getLastResult)
			timer.start()
		}
		
		private function getLastResult(e:Event):void{
			conn.call("last_result", onGetLastResult, null, {id:train_id})
		}
		private function onGetLastResult(o:Object):void{
			results.push( o.result )
			if(o.finished){
				onFinish()
			}else{
				facade.sendNotification( UPDATED, o.result)
			}
		}
		
		private function onFinish():void{
			timer.removeEventListener(TimerEvent.TIMER, getLastResult)
			timer.stop()
			
			conn.call("full_result", onGetFullResult, null, {id:train_id})
		}
		private function onGetFullResult(o:Object):void{
			results = o.results
			facade.sendNotification( COMPLETE )
		}
		
		public function show(train_id:String):void{
			conn.call("find_by_id", onShow, null, {id:train_id})
		}
		private function onShow(train:Object):void{
			results = train.train.results
			lines = train.lines
			facade.sendNotification( ON_SHOW, train)
		}
		
		public function list():void{
			conn.call("find_all", onList)
		}
		private function onList(trains:Array):void{
			facade.sendNotification( ON_LIST, trains)
		}
		
		//getters
		public function getVoByIndex(index:int):Object{
			for each(var vo:Object in lines){
				if(vo.index == index){
					return vo
					break
				}
			}
			return null
		}
		
			
	}
}