package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;

	public class MainKeyboardInteraction extends MovieClip {

		var vx;
		
		public function MainKeyboardInteraction() {
			// constructor code
			trace("keyboard (in)sanity");

			stage.addEventListener(KeyboardEvent.KEY_DOWN, myKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, myKeyUp);
			stage.addEventListener(Event.ENTER_FRAME, myEnterFrame);

			vx = 0;
		}

		function myEnterFrame(e: Event) {
			myRobot.x = myRobot.x + vx;
		}

		function myKeyUp(e: KeyboardEvent) {

			if (e.keyCode == Keyboard.LEFT) {
				vx = 0;
			}

			if (e.keyCode == Keyboard.RIGHT) {
				vx = 0;
			}
		}
		
		function myKeyDown(e:KeyboardEvent) {

			if (e.keyCode == Keyboard.LEFT) {
				vx = -5;
			}

			if (e.keyCode == Keyboard.RIGHT) {
				vx = 5;
			}
		}

	}

}