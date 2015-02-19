package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Mouse;

	public class MainDisplayList extends MovieClip {

		public function MainDisplayList() {
			// constructor code
			trace("sane?");
			redButton.addEventListener(MouseEvent.CLICK, redClicked);
		}

		function redClicked(e) {

			var myRobot = new Robot;

			trace(myRobot);

			myRobot.x = Math.random() * stage.stageWidth;
			myRobot.y = Math.random() * stage.stageHeight;

			myRobot.scaleX = 0.5;
			myRobot.scaleY = 0.5;


			trace("The number of children before adding is", numChildren);

			trace("The first child is", getChildAt(0));

			addChildAt(myRobot, 0);

			trace("The new robot is at index: " + getChildIndex(myRobot));

			trace("The number of children is now", numChildren);

			var myStar = new Star;

			myRobot.addChild(myStar);
			myStar.x = 0;
			myStar.y = -170;


			myRobot.addEventListener(MouseEvent.CLICK, robotClicked);



		}
		
		function robotClicked(e) {
			trace("This robot was clicked!");
			trace(e);
			
			trace(e.target, e.currentTarget);
			
			removeChild(e.currentTarget);
			
			//target: The object that was clicked
			//currentTarget: The object that is processing the event
			//i.e the object that has the listener
			//In this case we want to remove the object that registered the listener, which is the robot
		}

	}

}




