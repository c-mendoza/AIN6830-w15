package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class MainForLoops extends MovieClip {
				
		public function MainForLoops() {
			// constructor code
			
			var counter = 0;
			
			while(counter < 15) {
				trace(counter, "I'm repeating");
				counter = counter + 1;
			}
			
			
			var box;
/*				
			counter = 0;
			
			while(counter < 15) {
				box = new Box;
				box.x = 100 + ( (box.width + 10) * counter);
				box.y = 100;
				addChild(box);
				trace("Made a box!", counter);
				counter += 1;
			}
			*/
			
			
			for(var xCounter = 0; xCounter < 15; xCounter = xCounter + 1) {
				trace(xCounter);
				box = new Box;
				box.x = 100 + ( (box.width + 10) * xCounter);
				box.y = 100;
				addChild(box);
				trace("Made a box!", xCounter);
			}
			
			
		
		}
	}
	
}
