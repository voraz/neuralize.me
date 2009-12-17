package me.neuralize.train.view.components.comparative{
	import mx.controls.AdvancedDataGrid;
	import mx.controls.Label;
	
	public class Train_comparative_gridTip extends Label{
		
		public function Train_comparative_gridTip(){
			super();
		}
		
		override public function set data(value:Object) : void{
			super.data = value
		}
	}
}