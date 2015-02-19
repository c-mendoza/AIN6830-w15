package {

	import flash.display.MovieClip;
	import flash.events.*;

	public class ShakingMovieClip extends MovieClip {

		var shakiness: Number;
		var ox: Number;
		var oy: Number;
		var isShaking: Boolean;

		public function ShakingMovieClip() {
			// constructor code
			trace("ShakingMovieClip Constructor");

			//WANT TO INITIALIZE NUMERICAL VARS!
			shakiness = 50;
			ox = 0;
			oy = 0;

			isShaking = false;

			addEventListener(Event.ADDED_TO_STAGE, myAdded);
		}

		function myAdded(e: Event) {
			ox = x;
			oy = y;
			addEventListener(Event.ENTER_FRAME, myEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, myRemoved);
			addEventListener(MouseEvent.CLICK, myClicked);
		}

		function myRemoved(e: Event) {
			removeEventListener(Event.ENTER_FRAME, myEnterFrame);
			removeEventListener(MouseEvent.CLICK, myClicked);
		}

		function myClicked(e: MouseEvent) {
			trace("robot clicked");

			if (isShaking == true) {
				setShaking(false);
			} else {
				setShaking(true);
			}
		}

		function setShaking(shake:Boolean) {
			if (shake) {
				isShaking = false;
				x = ox;
				y = oy;
			} else {
				isShaking = true;
				ox = x;
				oy = y;
			}
		}


		function myEnterFrame(e: Event) {
			if (isShaking) {
				this.x = ox + ((Math.random() * 2) - 1) * shakiness;
				this.y = oy + ((Math.random() * 2) - 1) * shakiness;
			}
		}
	}

}