package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class MainDemo3 extends MovieClip {
		
		
		public function MainDemo3() {
			// constructor code
			trace("sanity");
			
			leftButton.addEventListener(MouseEvent.CLICK, leftButtonClicked);
			
			rightButton.addEventListener(MouseEvent.CLICK, rightButtonClicked);
			
		}
		
		function leftButtonClicked(e) {
			trace("left!");
			myRobot.x = myRobot.x - 10;
		}
		
		function rightButtonClicked(e) {
			trace("the other left!");
			
			myRobot.x = myRobot.x + 10;
			
		}
		
		
	}
	
}
