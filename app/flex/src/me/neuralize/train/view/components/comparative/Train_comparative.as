package me.neuralize.train.view.components.comparative{
	import me.neuralize.vo.TrainObject;
	
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.core.ClassFactory;

	public class Train_comparative extends Train_comparative_view{
		
		public function Train_comparative(){
			super();
		}
		
		public function setColumns(array:Array):void{
			columnsDataProvider = array
			columns = new Array()
			columns.push(controllColumn)
				
			for (var i:int=0; i<array.length; i++){
			
				var column:AdvancedDataGridColumn = new AdvancedDataGridColumn()
				column.headerText = array[i].title
				column.dataField = i.toString()
				column.headerRenderer = new ClassFactory(Train_comparative_gridTip)
				columns.push(column)
			}
			grid.columns = columns
		}
		
		public function addItem(item:TrainObject):void{
			if( dataProvider.indexOf(item.data) ==-1){
				dataProvider.push(item.data)
				grid.dataProvider = dataProvider
			}
			
			if(height==0){
				height = 200
			}
		}
		public function addItens(itens:Array):void{
			for(var i:int=0; i<itens.length; i++){
				addItem(itens[i])
			}
		}
		
		public function removeItem(item:*):void{
			var index:int = dataProvider.indexOf(item)
			if(index!=-1){
				dataProvider.splice(index, 1)
				grid.dataProvider = dataProvider
			}
			if(dataProvider.length==0)
				height = 0
			
		}
	}
}