package me.neuralize.datainsert.view.components.grid.columns.popup{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import me.neuralize.app.ApplicationFacade;
	import me.neuralize.datainsert.model.DatasetProxy;
	
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	public class Datainsert_columns_popup extends Datainsert_columns_popup_base{
		private static var instance:Datainsert_columns_popup
		private var index:int = -1
			
		public function Datainsert_columns_popup(){
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, onStart)
		}
		
		public static function getInstance():Datainsert_columns_popup{
			if(instance==null)
				instance = new Datainsert_columns_popup()
			return instance
		}
		
		private function onStart(e:FlexEvent=null):void{
			txtTitle.setFocus()
				
			txtMessage.visible = txtMessage.includeInLayout = false
			btCancel.addEventListener(MouseEvent.CLICK, clickCancel)
			btOk.addEventListener(MouseEvent.CLICK, clickOk)
		}
		
		private function clickOk(e:Event):void{
			if(valid){
				if(index==-1){
					ApplicationFacade.getInstance().sendNotification( DatasetProxy.ON_INSERT_COLUMN, getData() )
				}else{
					ApplicationFacade.getInstance().sendNotification( DatasetProxy.ON_EDIT_COLUMN, {index:index, data:getData()} )
				}
				clickCancel()
			}
			
		}
		
		private function get valid():Boolean{
			if(txtTitle.text != ""){
				return true
			}else{
				txtMessage.visible = txtMessage.includeInLayout = true
				txtTitle.setFocus()
				return false
			}
		}
		
		public function setData(data:Object, index:int=-1):void{
			this.index = index
		
			txtTitle.text = data.title
			txtDescription.text = data.description
			cbIncluded.selected = data.included
		}
		
		public function getData():Object{
			var data:Object = new Object()
			data.title = txtTitle.text
			data.description = txtDescription.text
			data.included = cbIncluded.selected
			return data
		}
		
		private function clickCancel(e:MouseEvent=null):void{
			txtTitle.text = ""
			txtDescription.text = ""
			
			PopUpManager.removePopUp(this)
		}
	}
}
