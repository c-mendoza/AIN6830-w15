package {

	import flash.display.MovieClip;
	import flash.events.*;

	public class MainForLoops extends MovieClip {

		public function MainForLoops() {
			// constructor code

			var counter = 0;
			var yCounter = 0;
			var myMc: Block;

			trace("here");
			/*			while (yCounter < 10) {
				while (counter < 10) {
					myMc = new Block;
					myMc.x = 50 + (counter * (myMc.width + 10));
					myMc.y = 50 + (yCounter * (myMc.height + 10));
					addChild(myMc);
					counter = counter + 1;
					trace(counter);
				}
				counter = 0;
				yCounter++;
				trace("yCounter", yCounter);
			}*/




			/*			for (var yCounter = 0; yCounter < 5; yCounter++) {
				for (var xCounter = 0; xCounter < 5; xCounter = xCounter + 1) {
					myMc = new Block;
					myMc.x = 50 + (xCounter * (myMc.width + 10));
					myMc.y = 50 + (yCounter * (myMc.height + 10));
					addChild(myMc);
				}
			}*/

			var myBar: Bar;
			for (var xCounter = 0; xCounter < 5; xCounter = xCounter + 1) {
				myBar = new Bar;
				myBar.x = 50 + (xCounter * (myBar.width + 10));
				myBar.y = stage.stageHeight / 2;
				addChild(myBar);
			}













		}
	}

}