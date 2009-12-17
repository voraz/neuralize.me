package br.com.voraz.konohen.konohen.controller{
	import br.com.voraz.konohen.konohen.model.KohonenProxy;
	import br.com.voraz.konohen.vo.NotesVo;
	import br.com.voraz.konohen.vo.StudentVo;
	
	import com.library.utils.VMath;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class KonohenController extends SimpleCommand implements ICommand{
		private var dimW:Number = 10;
		private var notas:Number = 48;
		private const nEntradas:Number = 25;
		private var nEpocas:Number = 10000;
		//private var nEpocas:Number = 100;
		private var rangeInicial:uint = 10;
		private var rangeFinal:uint = 2;
		
		private var w:Array = new Array();
		private var entradas:Array = new Array();
		private var dist:Array = new Array();
		
		private var students:Array;
		
		public function KonohenController(){
			super();
		}
		
		override public function execute(notification:INotification):void{
			
			students = notification.getBody() as Array;
			criaMatPesos();
			criaEntradas();
			
			
			
			//inicializa a matriz dist
			for(var i:uint=0; i<dimW; i++){
				var m1:Array = new Array();
				dist.push(m1);
				
				for(var j:uint=0; j<dimW; j++){
					var m2:Array = new Array();
					m1.push(m2);
				}
			}
			treinar();
		}
		
		
		
		private function criaMatPesos():void{ //cria a matriz de pesos
			var notaMinima:Number = 5;
			var notaMaxima:Number = 10;
			
			for(var l:uint=0; l<dimW; l++){
				var melhoria:Number = l/dimW * (notaMaxima-notaMinima);
				
				var m1:Array = new Array();
				w.push(m1);
				
				for(var c:uint=0; c<dimW; c++){
					var m2:Array = new Array();
					m1.push(m2);
				
					for(var nota:uint=0; nota<notas; nota++){
						var m3:Array = new Array();
						m2.push(m3);
				
						var pesoEscolhido:Number = notaMinima + VMath.randon(0,notaMaxima-notaMinima);
						//var pesoEscolhido:Number = notaMinima + melhoria + VMath.randon(0,notaMaxima-notaMinima-melhoria);
						w[l][c][nota] = pesoEscolhido;
					}
					
				}
			}
		}
		
		private function criaEntradas():void{
			for(var i:uint=0; i<nEntradas; i++){
				var m1:Array = new Array();
				entradas.push(m1);
				
				var student:StudentVo = students[i];
				
				for(var j:uint=0; j<notas; j++){
					var m2:Array = new Array();
					m1.push(m2);
					
					
					entradas[i][j] = NotesVo(student.notes[j]).note; 
				}
			}
		}
		
		
		private var lmin:Number = 0;
		private var cmin:Number = 0;
		private var dmin:Number = 99999.9;
		 
		private var	minimo_l:Number = 0;
		private var	maximo_l:Number = 0;
		private var	minimo_c:Number = 0;
		private var	maximo_c:Number = 0;

		
		private function treinar():void{
			var range:uint = rangeInicial;
			var alfa:Number = 0.05;
			for(var epoca:uint=0; epoca<nEpocas; epoca++){
				alfa = alfa*(0.9999);
				facade.sendNotification(KohonenProxy.ADDTEXT, "\n Época "+epoca );
				if( epoca%1000==0 || epoca==nEpocas-1){
					facade.sendNotification(KohonenProxy.ADDTEXT, "\n\n =================================== epoca="+epoca+"===================================");
				}
				
				for(var ii:uint=0; ii<nEntradas; ii++){ //treinamento da rede
					var i:uint;
					if( epoca%1000==0 || epoca==nEpocas-1){
						i = ii;
					}else{
						i = VMath.randon(0, nEntradas-1);
					}
					
					buscarMaisProximo(i);
					
					if( epoca%1000==0 || epoca==nEpocas-1){ //na última época, mostra quem vence
						//mostra passo e entrada apresentada
						
						facade.sendNotification(KohonenProxy.ADDTEXT,
								"\n"+
								"passo: "+(i+1)+
								"	range: "+range+
								"	entrada["+i+"]: "+
								"	mais próximo: w["+lmin+","+cmin+"]" + 
								"	distância: "+dmin.toPrecision(5)+
								"	alfa: "+alfa.toPrecision(5)+
								"\n"
							);
						/*	
						for(var nota:Number=0; nota<notas; nota++){
							//facade.sendNotification(KohonenProxy.ADDTEXT, Number(entradas[i][nota]).toPrecision(2) +"	")
						}
						//mostra o mais próximo
						for(nota=0; nota<notas; nota++){
							//facade.sendNotification(KohonenProxy.ADDTEXT, Number(w[lmin][cmin][nota]).toPrecision(2) +"	")
						}
						*/
					}
					
					//mostra matriz de pesos
					//aprender
					ajustarLimites(lmin, range, "l");
					ajustarLimites(cmin, range, "c");
					
					var proximidade:Number = epoca/nEpocas;
					range = rangeInicial-(rangeInicial-rangeFinal)*proximidade;
					for(var l:uint=minimo_l; l<=maximo_l; l++){
						for(var c:uint=minimo_c; c<=maximo_c; c++){
							var chapeu:Number = Math.abs(lmin-1)+Math.abs(cmin-c);
							if(chapeu==0){
								chapeu = l;
							}
							for(var nota:Number=0; nota<notas; nota++){
								w[l][c][nota] = w[l][c][nota]+alfa / chapeu*(entradas[i][nota]-w[l][c][nota]) ;
							}
						}
					}
				}
			}
		}
		
		
		private function buscarMaisProximo(i:Number):void{
			lmin = 0;
			cmin = 0;
			dmin = 99999.9
			dist[0][0] = dmin;
			for(var l:uint=0; l<dimW; l++){
				for(var c:uint=0; c<dimW; c++){
					dist[l][c] = distancia(l, c, i);
					if( Math.abs(dist[l][c]) < Math.abs(dmin) ){
						lmin = l;
						cmin = c;
						dmin = dist[l][c];
					}
				}
			}
		}
		
		private function distancia(l:Number, c:Number, i:Number):Number{
			var somaDif:Number = 0;
			
			for(var nota:uint=0; nota<notas; nota++){
				var dif:Number = w[l][c][nota]-entradas[i][nota];
				if(dif<0){
					dif = -dif;
				}
				somaDif = somaDif + dif;
			}
			
			return somaDif;
		}
		
		private function ajustarLimites(vencedor:Number, range:Number, tipo:String):void{
			var min:Number = 0;
			var max:Number = 0;
			
			if( vencedor-range<0 ){
				min = 0;
			}else{
				min = vencedor-range;
			}
			
			if( vencedor+range>=dimW ){
				max = dimW-1
			}else{
				max = vencedor+range;
			}
			
			if(tipo=="l"){
				minimo_l = min;
				maximo_l = max;
			}else{
				minimo_c = min;
				maximo_c = max;
			}
		}
	}
}