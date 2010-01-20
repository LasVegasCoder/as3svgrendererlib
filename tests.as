﻿package {
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.text.TextField;

	import com.lorentz.SVG.*;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import fl.controls.List;
	import fl.events.ListEvent;
	import fl.data.DataProvider;
	
	import flash.events.MouseEvent;
	
	import flash.utils.getTimer;

	public class tests extends Sprite {
		import flash.net.URLLoader;
		import flash.net.URLRequest;
		
		public function tests() {
			var array_itens:Array = new Array(
				"tests/text01.svg",
				"tests/tspan01.svg",
				"tests/tspan02.svg",
				"tests/Units.svg",
				"tests/lingrad01.svg",
				"tests/arcs01.svg",
				"tests/arcs02.svg",
				"tests/butterfly.svg",
				"tests/circles1.svg",
				"tests/ellipse1.svg",
				"tests/ellipse2.svg",
				"tests/gradiente.svg",
				"tests/gradiente_linear.svg",
				"tests/gradients1.svg",
				"tests/gradients2.svg",
				"tests/line1.svg",
				"tests/lion.svg",
				"tests/path1.svg",
				"tests/path2.svg",
				"tests/paths1.svg",
				"tests/paths2.svg",
				"tests/paths3.svg",
				"tests/polygons1.svg",
				"tests/quadbezier1.svg",
				"tests/rect1.svg",
				"tests/rect2.svg",
				"tests/rect4.svg",
				"tests/skew1.svg",
				"tests/tiger.svg",
				"tests/toucan.svg",
				"tests/image.svg"
				);

			lista.dataProvider = new DataProvider(array_itens);
			lista.addEventListener(fl.events.ListEvent.ITEM_CLICK, on_item_click);
		}
		
		private function on_item_click(e:ListEvent){
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, xmlComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.load( new URLRequest(e.item.data));
			
			information.text = "";
			if(shp!=null && shp.parent!=null)
				this.removeChild(shp);
				
			information.text = "Loading";
			
			stage.removeEventListener(MouseEvent.CLICK, traceClick);
		}
		private function onError(e:IOErrorEvent){
			information.text = "Cannot load the file";
		}
		
		private var shp:SVGRenderer;
		private function xmlComplete(e:Event) {
			information.text = "Rendering";
			
			XML.ignoreWhitespace = false;
			var svg:XML = new XML(e.target.data);
			XML.ignoreWhitespace = true;
			
			var i:Number = getTimer();
			shp = new SVGRenderer(svg);
			var f:Number = getTimer();
			
			information.text = "Time elapsed: "+Number(f-i).toString();

			this.addChildAt(shp, 0);
			
			//Add the listener to find problems
			stage.addEventListener(MouseEvent.CLICK, traceClick);
		}
		function traceClick(e:MouseEvent):void {
			if(shp.contains(e.target as DisplayObject)){
				trace(e.target.name);
			}
		}
	}
}