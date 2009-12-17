package br.com.voraz.konohen.vo{
	import br.com.voraz.konohen.notes.model.NotesProxy;
	
	public class StudentVo{
		
		public var id:Number;
		public var name:String;
		public var ra:Number
		private var _notes:Array;
				
		public function StudentVo(id:Number, name:String){
			this.id = id;
			this.name = name;
		}
		
		public function get notes():Array{
			if(_notes==null){
				var array:Array = new Array();
				for(var i:Number=0; i<NotesProxy.notes.length; i++){
					var note:NotesVo = NotesProxy.notes[i];
					if(note.studentId==this.id){
						array.push(note);
					}
				}
				_notes = array;
			}
			return _notes;
		}

	}
}