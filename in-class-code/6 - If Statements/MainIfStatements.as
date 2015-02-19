package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class MainIfStatements extends MovieClip {
		
		
		public function MainIfStatements() {
			// constructor code
			
			mouseDemo1Button.addEventListener(MouseEvent.CLICK, launchDemo1);
			mouseDemo2Button.addEventListener(MouseEvent.CLICK, launchDemo2);
			
		}
		
		function launchDemo1(e:MouseEvent) {
			trace("Launching Mouse Demo 1...");
			var demo1 = new MouseDemo1;
			addChild(demo1);
		}
				function launchDemo2(e:MouseEvent) {
			trace("Launching Mouse Demo 1...");
			var demo2 = new MouseDemo2;
			addChild(demo2);
		}
	}
	
}




