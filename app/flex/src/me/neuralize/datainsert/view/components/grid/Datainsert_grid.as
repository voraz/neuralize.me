package me.neuralize.datainsert.view.components.grid{
	
	import flash.display.DisplayObject;
	
	import me.neuralize.datainsert.view.components.grid.columns.header.Datainsert_columns_header;
	import me.neuralize.datainsert.view.components.grid.columns.headerImage.HeaderImageView;
	import me.neuralize.datainsert.view.components.grid.columns.popup.Datainsert_columns_popup;
	import me.neuralize.datainsert.view.components.grid.lines.edit.Datainsert_lines_edit;
	import me.neuralize.datainsert.view.components.grid.lines.image.Datainsert_lines_image;
	import me.neuralize.datainsert.view.components.grid.lines.remove.Datainsert_lines_remove;
	
	import mx.collections.ArrayCollection;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.core.ClassFactory;
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	public class Datainsert_grid extends Datainsert_grid_base{
		[Bindable]
		public var matrixProvider:Array = new Array()
		private var provider:ArrayCollection
			
		public var arrayColumns:Array = new Array()
		public var columnsProvider:Array = new Array()
		
		
			
		public function Datainsert_grid(){
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, onStart)
		}
		
		private function onStart(e:FlexEvent):void{
			addNewCollumn({}) //remove
			addNewCollumn({}) //image
			
			provider = new ArrayCollection()
			this.dataProvider = provider
		}
		
		public function addNewCollumn(data:Object):void{
			
			var column:AdvancedDataGridColumn
			switch(arrayColumns.length){
				case 0:		
					column = getFirstColumn()
					break
				case 1:		
					column = getImageColumn() 
					break
				default: 	
					column = getOtherColumn() 
			}
				
			arrayColumns.push( column )
			columnsProvider.push( data )
				
			updateGrid()
		}
		
		
		private function getFirstColumn():AdvancedDataGridColumn{
			var col:AdvancedDataGridColumn = new AdvancedDataGridColumn()
			col.itemRenderer = new ClassFactory(Datainsert_lines_remove)
			col.editable = false
			col.width = 35
			col.headerText = ""
			return col
		}
		private function getOtherColumn():AdvancedDataGridColumn{
			var col:AdvancedDataGridColumn = new AdvancedDataGridColumn()
			col.headerRenderer = new ClassFactory(Datainsert_columns_header)
			col.itemRenderer = new ClassFactory(Datainsert_lines_edit)
			col.width = 120
			col.editable = false
			width = width+col.width 
			return col
		}
		private function getImageColumn():AdvancedDataGridColumn{
			var col:AdvancedDataGridColumn = new AdvancedDataGridColumn()
			col.itemRenderer = new ClassFactory(Datainsert_lines_image)
			col.headerRenderer = new ClassFactory(HeaderImageView)
			col.editable = false
			col.width = 80
			col.headerText = "Image"
			return col
		}
		
		public function editCollumn(index:int):void{
			PopUpManager.addPopUp(Datainsert_columns_popup.getInstance(), FlexGlobals.topLevelApplication as DisplayObject, true)
			PopUpManager.centerPopUp(Datainsert_columns_popup.getInstance())
			Datainsert_columns_popup.getInstance().setData(columnsProvider[index], index)
		}
		public function onEditCollumn(index:int, data:Object):void{
			columnsProvider[index] = data
			updateGrid()
		}
		
		public function removeColum(index:int):void{
			var col:AdvancedDataGridColumn = arrayColumns[index] as AdvancedDataGridColumn
			arrayColumns.splice(index, 1)
			columnsProvider.splice(index, 1)
			/*for (var i:int=0; i<matrixProvider.length; i++){
				matrixProvider[i].data.splice(index-DatasetProxy.COLUMN_START, 1)
			}*/
			width = width-col.width
			updateGrid()
		}
		public function removeLine(data:Object):void{
			for (var i:int=0; i<provider.length; i++){
				if(provider.getItemAt(i) == data){
					provider.removeItemAt(i)
					break
				}
				/*if(matrixProvider[i]==data){
					matrixProvider.splice(i, 1)
					break
				}*/
			}
			updateGrid()
		}
		
		public function addNewLine():void{
			provider.addItem({})
		}
		
		private function resizeAllColumns():void{
			var tam:Number = this.width/arrayColumns.length
				
			for(var i:int = 0; i<arrayColumns.length; i++){
				arrayColumns[i].width = tam
			}
		}
		
		public function show(o:Object):void{
			for each(var vo:Object in o.columns){
				addNewCollumn(vo)
			}
			matrixProvider = o.lines
			dataProvider = matrixProvider
		}
		
		
		private function updateGrid():void{
			//columns = arrayColumns
			/*for(var i:int=DatasetProxy.COLUMN_START; i<arrayColumns.length; i++){
				arrayColumns[i].dataField = (i-DatasetProxy.COLUMN_START).toString()
			}*/
		}
		
		override public function set data(value:Object) : void{
			this.data = value
		}
	} 
}