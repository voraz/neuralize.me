package me.neuralize.app.view.components.util.picture{
	import br.com.voraz.flash.address.UrlUtil;
	import br.com.voraz.flash.display.BaseButton;
	import br.com.voraz.flash.image.ImageUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.PixelSnapping;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	public class PictureLoader extends UIComponent{
		
		private var loader:Loader = new Loader()
		private var image:UIComponent = new UIComponent()
		private var button:BaseButton = new BaseButton()
		
		private var _width:Number
		private var _height:Number
		
		public function PictureLoader(width:Number=100, height:Number=100){
			super();
			_width = width
			_height = height
			addEventListener(FlexEvent.CREATION_COMPLETE, start)
		}
		private function start(e:Event):void{
			addChild(image)
			addChild(button)
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete)
		}
		
		
		public function loadBytes(bytes:ByteArray):void{
			cleanImage()
			loader.loadBytes( bytes )
		}
		public function load(url:String):void{
			cleanImage()
			loader.load( new URLRequest( UrlUtil.removeDoubleBar(url) ) )
		}
		private function cleanImage():void{
			while(image.numChildren>0){
				image.removeChildAt(0)
				image.scaleX = image.scaleY = 1
			}
				
		}
		
		
		private function onLoadComplete(e:Event):void{
			var bmd:BitmapData = new BitmapData(loader.width, loader.height, true, 0);
			bmd.draw(loader)
			image.addChild( new Bitmap(bmd, PixelSnapping.AUTO, true) );
			ImageUtil.scale(image, _width, _height)
		}
		
		
		override public function set width(value:Number) : void{
			if(_width!=value){
				_width = value
				button.width = _width
			}
		}
		override public function set height(value:Number) : void{
			if(_height!=value){
				_height = value
				button.height = _height
			}
		}
		override public function get width() : Number{
			return _width
		}
		override public function get height() : Number{
			return _height
		}
		public function get imageWidth():Number{
			try{
				return image.getChildAt(0).width
			}catch(e:*){}
			return height
		}
		public function get imageHeight():Number{
			try{
				return image.getChildAt(0).height
			}catch(e:*){}
			return height
		}
		
		
		
	}
}