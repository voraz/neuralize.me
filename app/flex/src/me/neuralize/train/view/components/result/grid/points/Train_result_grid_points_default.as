package me.neuralize.train.view.components.result.grid.points{
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import me.neuralize.app.ApplicationFacade;
	import me.neuralize.app.view.components.util.picture.PictureGrid;
	import me.neuralize.train.model.TrainProxy;
	import me.neuralize.vo.TrainObject;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;

	public class Train_result_grid_points_default extends UIComponent{
		
		public var vo:TrainObject
		private var label:TextField = new TextField()
		private var picture:PictureGrid = new PictureGrid()
			
		private var _collided:Boolean = false
		private var _width:Number
		private var _height:Number
		
		public var finalX:Number = 0
		public var finalY:Number = 0
		public var finalScale:Number = 1	
			
		public function Train_result_grid_points_default(param_vo:Object){
			super();
			vo = new TrainObject(param_vo)
			addEventListener(FlexEvent.CREATION_COMPLETE, start)
		}
		
		private function start(e:Event):void{
			if(vo.pictures!=null){
				picture.show( vo.pictures )
			}else{
			}
			
			addChild(label)
			addChild(picture)
			
			setButton()
			
			label.text = vo.data[0]
			changeLabelField(-1)
		}
		
		private function setButton():void{
			addEventListener(MouseEvent.CLICK, click)
		}
		
		
		private function click(e:Event):void{
			ApplicationFacade.getInstance().sendNotification(TrainProxy.GRID_ITEM_CLICK, vo)
		}
		
		public function changeLabelField(index:int):void{
			if(index==-1){
				label.alpha = 0
				label.visible = false
			}else{
				label.alpha = 1
				label.visible = true
				label.text = vo.data[index]
				label.y = picture.imageHeight
			}
			
		}
		
		public function set collided(bol:Boolean):void{
			_collided = bol
			TweenLite.killTweensOf(label)
			TweenLite.killTweensOf(picture)
			
			if(bol){
				//TweenLite.to( label, 1.5, {alpha:0.5, ease:Quad.easeIn} )
				//TweenLite.to( picture, 1.5, {alpha:0.5, ease:Quad.easeIn} )
			}else{
				//TweenLite.to( label, 1, {alpha:1, ease:Quad.easeOut} )
				//TweenLite.to( picture, 1, {alpha:1, ease:Quad.easeOut} )
			}
		}
		public function get collided():Boolean{
			return _collided
		}
		
		
		public function tween():void{
			TweenLite.killTweensOf(this)
			TweenLite.to( this, 2, {x:finalX, y:finalY, scaleX:finalScale, scaleY:finalScale} )
		}
		
		/*
		override public function set width(value:Number) : void{
			_width = value
			test()
		}
		override public function set height(value:Number) : void{
			_height = value
			test()
		}
		*/
		override public function get width():Number{
			return picture.imageWidth*finalScale
		}
		override public function get height():Number{
			return picture.imageHeight*finalScale
		}
		/*
		override public function set x(value:Number):void{
			finalX = value
			super.x = value
		}
		override public function set y(value:Number):void{
			finalY = value
			super.x = value
		}
		*/
	}
}