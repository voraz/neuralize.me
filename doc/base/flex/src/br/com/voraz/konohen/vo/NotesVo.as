package br.com.voraz.konohen.vo{
	public class NotesVo{
		
		public var id:Number;
		//public var student:StudentVo;
		//public var discipline:DisciplinesVo;
		public var studentId:Number;
		public var disciplineId:Number;
		public var note:Number;
		
		public function NotesVo(studentId:Number, disciplineId:Number, note:Number){
			this.studentId = studentId;
			this.disciplineId = disciplineId;
			this.note = note;
		}

	}
}