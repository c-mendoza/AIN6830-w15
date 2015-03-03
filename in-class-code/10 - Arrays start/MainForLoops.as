package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class MainForLoops extends MovieClip {
				
		public function MainForLoops() {
			// constructor code
			
			var counter = 0;
				
			var myMc:Block;
			
			while(counter < 10) {
				myMc = new Block;
				
				myMc.x = 50 + (counter * myMc.width);
				myMc.y =  stage.stageHeight / 2;
				
				addChild(myMc);
				
				counter = counter + 1;
				trace(counter);
			}
			
		}
	}
	
}
