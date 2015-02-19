package {

	import flash.display.MovieClip;
	import flash.events.*;


	public class MainProgrammaticAnimation extends MovieClip {
		
		var toPosX;
		var toPosY;

		public function MainProgrammaticAnimation() {
			// constructor code
			trace("sanity");

			//

			addEventListener(Event.ENTER_FRAME, myEnterFrameHandler);
			stage.addEventListener(MouseEvent.CLICK, myClickHandler);

		}

		function myEnterFrameHandler(e) {
			myRobot.x = (toPosX - myRobot.x) / 7 + myRobot.x;
			myRobot.y += (toPosY - myRobot.y) / 7;
			
		}

		function myClickHandler(e: MouseEvent) {
			trace("clicked");
			//trace(e.localX, e.localY);
			toPosX = e.stageX;
			toPosY = e.stageY;

		}
	}

}