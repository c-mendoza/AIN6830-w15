package {

	import flash.display.MovieClip;
	import flash.events.*;


	public class MainAddingDemo extends MovieClip {


		public function MainAddingDemo() {
			// constructor code

			redButton.addEventListener(MouseEvent.CLICK, buttonClicked);

			trace("Script begins: " + this);
		}


		function buttonClicked(e: MouseEvent) {
			var myRobot = new Robot;

			addChild(myRobot);

			myRobot.scaleX = 0.5;
			myRobot.scaleY = 0.5;

			myRobot.x = (Math.random() * stage.stageWidth);
			myRobot.y = (Math.random() * stage.stageHeight);

			//swapChildren(myRobot, redButton);

			myRobot.addEventListener(MouseEvent.CLICK, robotClicked);
			trace("Button clicked: " + this + " " + e.target + e.target.parent);

		}

		function robotClicked(e: MouseEvent) {
			trace("Robot clicked!");

			//e.target: The object that triggered the event. In this case, the robot that was clicked
			var clickedRobot = e.target;
			removeChild(clickedRobot);

			var explosion = new Explosion;

			//Disable the mouse for the explosion Movie Clip
			explosion.mouseEnabled = false;

			explosion.scaleX = 2;
			explosion.scaleY = 2;

			explosion.x = e.stageX;
			explosion.y = e.stageY;

			addChild(explosion);
		}

	}

}