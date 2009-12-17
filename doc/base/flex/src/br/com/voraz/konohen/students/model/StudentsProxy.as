package br.com.voraz.konohen.students.model{
	import br.com.voraz.konohen.vo.StudentVo;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class StudentsProxy extends Proxy implements IProxy{
		public static const NAME:String = "StudentsProxy";
		
		public static const LIST_GOT:String = "StudentsProxy_list_got";
		public static var students:Array;
		
		public function StudentsProxy(data:Object=null){
			super(NAME, data);
		}
		
		override public function onRegister():void{
			var array:Array = [
				new StudentVo(1, "Alex"),
				new StudentVo(2, "Belchior"),
				new StudentVo(3, "Camila Belussi"),
				new StudentVo(4, "Camila Mayumi"),
				new StudentVo(5, "Carlos"),
				new StudentVo(6, "Clayton Hermínio"),
				new StudentVo(7, "Clayton Issamu"),
				new StudentVo(8, "Deivis"),
				new StudentVo(9, "Douglas"),
				new StudentVo(10, "Edson"),
				new StudentVo(11, "Eduardo"),
				new StudentVo(12, "Edwaldo"),
				new StudentVo(13, "Fábio"),
				new StudentVo(14, "Fabricio"),
				new StudentVo(15, "Fernanda"),
				new StudentVo(16, "Hélio"),
				new StudentVo(17, "Igor"),
				new StudentVo(18, "Lizandra"),
				new StudentVo(19, "Luigui"),
				new StudentVo(20, "Luís"),
				new StudentVo(21, "Mariana"),
				new StudentVo(22, "Maycon"),
				new StudentVo(23, "Paulo"),
				new StudentVo(24, "Renato"),
				new StudentVo(25, "Rodrigo")
			]
			
			onListGot(array);
		}
		
		private function onListGot(array:Array):void{
			students = array;
			facade.sendNotification(LIST_GOT, array);
		}
		
	}
}