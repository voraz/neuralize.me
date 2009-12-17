package me.neuralize.train.view.components.bar{
	public class Train_bar extends Train_bar_view{
		
		public function Train_bar(){
			super();
		}
		
		public function get parameters():Object{
			var o:Object = new Object()
				
			o.dataset_id = list.selectedItem.id
			o.training_times = 	training_times.text
			
			o.weight_columns = exibitionColumns.value
			o.weight_lines = exibitionLines.value
			
			o.randomize_weights = randomizeWeights.selected
			o.start_random_weights = startWeights.text
			o.end_random_weights = endWeights.text
				
			o.start_range = startRange.text
			o.end_range = endRange.text
			
			o.start_alpha = startAlpha.text
			o.end_alpha = endAlpha.text
			
			o.update_at = update_at.text
			return o
		}
		
		public function set parameters(o:Object):void{
			training_times.text = o.training_times 	
			
			exibitionColumns.value = o.weight_columns
			exibitionLines.value = o.weight_lines
			
			randomizeWeights.selected = o.randomize_weights
			startWeights.text = o.start_random_weights
			endWeights.text = o.end_random_weights
			
			startRange.text = o.start_range
			endRange.text = o.end_range
			
			startAlpha.text = o.start_alpha
			endAlpha.text = o.end_alpha
			
			update_at.text + o.update_at
		}
	}
}