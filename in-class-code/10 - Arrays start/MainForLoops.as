package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class MainForLoops extends MovieClip {
				
		public function MainForLoops() {
			// constructor code
			
			var counter = 0;
				
			var bar:Bar;
			
			while(counter < 10) {
				bar = new Bar;
				
				bar.x = 50;
				bar.y =  stage.stageHeight / 2;
				
				addChild(bar);
				
				counter = counter + 1;
				trace(counter);
			}
			
		}
	}
	
}
