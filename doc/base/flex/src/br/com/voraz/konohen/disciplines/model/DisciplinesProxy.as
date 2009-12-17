package br.com.voraz.konohen.disciplines.model{
	import br.com.voraz.konohen.vo.DisciplineVo;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class DisciplinesProxy extends Proxy implements IProxy{
		public static const NAME:String = "DisciplinesProxy";
		
		public static const LIST_GOT:String = "DisciplinesProxy_list_got";
		
		public var array:Array;
		
		public function DisciplinesProxy(data:Object=null){
			super(NAME, data);
		}
		
		override public function onRegister():void{
			getDisciplines();
		}
		
		private function getDisciplines():void{
			var array:Array = [
				new DisciplineVo(1, "Cálculo diferencial e integral I"),
				new DisciplineVo(2, "Física I"),
				new DisciplineVo(3, "Geometria analítica"),
				new DisciplineVo(4, "Inglês técnico I"),
				new DisciplineVo(5, "Introdução a viência da computação"),
				new DisciplineVo(6, "Linguagens técnicas de programação I"),
				new DisciplineVo(7, "Microinformática"),
				new DisciplineVo(8, "Álgebra Linear"),
				new DisciplineVo(9, "Cálculo diferencial e integral II"),
				new DisciplineVo(10, "Estrutura de dados I"),
				new DisciplineVo(11, "Física II"),
				new DisciplineVo(12, "Inglês técnico II"),
				new DisciplineVo(13, "Lingua portuguesa"),
				new DisciplineVo(14, "Lógica matemática e aplicações"),
				new DisciplineVo(15, "Probabilidade e estatística"),
				new DisciplineVo(16, "Estrutura de dados II"),
				new DisciplineVo(17, "Informática e sociedade"),
				new DisciplineVo(18, "Lingua portuguesa II"),
				new DisciplineVo(19, "Linguagens técnicas de programação II"),
				new DisciplineVo(20, "Linguagens montadoras"),
				new DisciplineVo(21, "Lógica e principios de sistemas digitais"),
				new DisciplineVo(22, "Sistemas operacionais"),
				new DisciplineVo(23, "Métodos numéricos"),
				new DisciplineVo(24, "Organização de computadores"),
				new DisciplineVo(25, "Processos estocásticos"),
				new DisciplineVo(26, "Teoria dos grafos e aplicações"),
				new DisciplineVo(27, "Banco de dados I"),
				new DisciplineVo(28, "Engenharia de software I"),
				new DisciplineVo(29, "Introdução a arquitetura de computadores"),
				new DisciplineVo(30, "Laboratório de eletrônica digital"),
				new DisciplineVo(31, "Linguagens técnicas de programação III"),
				new DisciplineVo(32, "Sistemas de informação"),
				new DisciplineVo(33, "Teoria e técnicas de construção de compiladores"),
				new DisciplineVo(34, "Banco de dados II"),
				new DisciplineVo(35, "Computação gráfica"),
				new DisciplineVo(36, "Eficiência e complexidade de algorítmos"),
				new DisciplineVo(37, "Engenharia de software II"),
				new DisciplineVo(38, "Microprocessadores e microcontroladores"),
				new DisciplineVo(39, "Programação concorrente"),
				new DisciplineVo(40, "Sistemas distribuidos"),
				new DisciplineVo(41, "Inteligência artificial"),
				new DisciplineVo(42, "Multimídia e hipermídia"),
				new DisciplineVo(43, "Projeto de graduação"),
				new DisciplineVo(44, "Redes de computadores"),
				new DisciplineVo(45, "Estágio"),
				new DisciplineVo(46, "Formação de empreendedores")
			]

			onGetDisciplines(array);
		}
		private function onGetDisciplines(array:Array):void{
			this.array = array;
			facade.sendNotification( LIST_GOT, array);
		}
		
	}
}