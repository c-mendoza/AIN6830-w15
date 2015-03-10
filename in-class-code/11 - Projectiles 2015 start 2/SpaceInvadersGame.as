package {
	import flash.display.*;
	import flash.events.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class SpaceInvadersGame extends MovieClip {
		var player: MovieClip;
		var playerAccel: Number = 1; //Player acceleration
		var playerVx: Number; //Player x velocity

		var leftArrowDown: Boolean = false;
		var rightArrowDown: Boolean = false;
		var spacebarDown: Boolean = false;


		public function SpaceInvadersGame() { // constructor code 

			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		function addedToStage(e: Event) {

			player = new Player();
			addChild(player);
			player.x = stage.stageWidth / 2;
			player.y = 340;
			playerVx = 0;



			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);

			stage.focus = stage;

		}


		//Function that handles firing a missile.
		function fireMissile() {

		}


		function enterFrameHandler(e: Event) {
			

			//////////////////////////////////////////////
			//Update missiles and enemies //



			//////////////////////////////////////////////
			//Update timer //
			
			//??
			
			
			//////////////////////////////////////////////
			// Firing missiles //

			//??

			//////////////////////////////////////////////
			// Player motion //

			if (rightArrowDown == true) {
				playerVx += playerAccel;
			}

			if (leftArrowDown == true) {
				playerVx -= playerAccel;
			}

			player.x += playerVx;
			player.x = Math.round(player.x);

			playerVx *= 0.7; //"Friction"

			if (Math.abs(playerVx) < 0.1) {
				playerVx = 0;
			}

			var pw2 = player.width / 2;
			if (player.x < pw2) {
				player.x = pw2;
			} else if (player.x > stage.stageWidth - pw2 ) {
				player.x = stage.stageWidth - pw2;
			}
		}


		function keyDownHandler(e: KeyboardEvent) {
			if (e.keyCode == Keyboard.LEFT) {
				leftArrowDown = true;
			}
			if (e.keyCode == Keyboard.RIGHT) {
				rightArrowDown = true;
			}
			if (e.keyCode == Keyboard.SPACE) {
				spacebarDown = true;
			}
		}

		function keyUpHandler(e: KeyboardEvent) {
			if (e.keyCode == Keyboard.LEFT) {
				leftArrowDown = false;
			}
			if (e.keyCode == Keyboard.RIGHT) {
				rightArrowDown = false;
			}
			if (e.keyCode == Keyboard.SPACE) {
				spacebarDown = false;
			}
		}
	}
}