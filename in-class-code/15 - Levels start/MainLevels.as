package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;
	import ain6830.*;

	public class MainLevels extends Game {

		public function MainLevels() {
			// constructor code

			stage.focus = stage;
			

			var myPlayer:PlatformPlayer = new PlatformPlayer;
			myPlayer.animationRight = new LinkAnimationRight;
			myPlayer.animationUp = new LinkAnimationUp;
			myPlayer.animationDown = new LinkAnimationDown;
			myPlayer.animationStopDown = new LinkAnimationStopDown;
			myPlayer.animationStopUp = new LinkAnimationStopUp;
			myPlayer.animationStopRight = new LinkAnimationStopRight;
			
			myPlayer.baseScale = 2;
			myPlayer.frictionX = myPlayer.frictionY = 0.35;
			myPlayer.accelerationX = 2.6;
			myPlayer.setX(200);
			myPlayer.setY(200);
			myPlayer.jumpForce = -22;
			myPlayer.gravity = 0.7;
			
			player = myPlayer;

			
			currentLevel = new Level1;
			

		}



	}

}