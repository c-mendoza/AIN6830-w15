package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;

	public class DowntownPage extends MovieClip {

		var vx;
		var theGame: MainNavigableGame;
		var upArrowDown: Boolean;

		public function DowntownPage() {
			// constructor code
			trace("Downtown Page Constructor");

			addEventListener(Event.ADDED_TO_STAGE, myAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, myRemovedFromStage);

			vx = 0;

		}

		function setGame(aGame: MainNavigableGame) {
			theGame = aGame;


			theGame.player.y = 300;
			theGame.player.x = 590;
			theGame.player.scaleX = 0.3;
			theGame.player.scaleY = 0.3;

			addChild(theGame.player);

			trace("The game in DowntownPage:", theGame);
		}

		function myAddedToStage(e: Event) {
			trace("DP added to stage");
			stage.addEventListener(KeyboardEvent.KEY_DOWN, myKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, myKeyUp);
			addEventListener(Event.ENTER_FRAME, myEnterFrame);
		}

		function myRemovedFromStage(e: Event) {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, myKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, myKeyUp);
			removeEventListener(Event.ENTER_FRAME, myEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, myAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, myRemovedFromStage);
		}

		function myKeyUp(e: KeyboardEvent) {
			//trace("key up");
			if (e.keyCode == Keyboard.LEFT) {
				vx = 0;
			}

			if (e.keyCode == Keyboard.RIGHT) {
				vx = 0;
			}
			if (e.keyCode == Keyboard.UP) {
				upArrowDown = true;
			}
		}

		function myKeyDown(e: KeyboardEvent) {
			//trace("key down");
			if (e.keyCode == Keyboard.LEFT) {
				vx = -5;
			}

			if (e.keyCode == Keyboard.RIGHT) {
				vx = 5;
			}

			if (e.keyCode == Keyboard.UP) {
				upArrowDown = true;
			}
		}

		//vx -5;
		//x is 1
		function myEnterFrame(e: Event) {
			/*trace("DP - Enter Frame");*/
			theGame.player.x = theGame.player.x + vx;

			if (theGame.player.x < 0) {
				//we do something
				theGame.player.x = 0;
			} else if (theGame.player.x > stage.stageWidth) {
				//Something...
				trace("Exit right!");
				var nextPage = new UptownPage;
				removeChild(theGame.player);
				nextPage.setGame(theGame);
				theGame.player.x = 0;
				theGame.addChild(nextPage);
				theGame.removeChild(this);
			}

			if (hatBuilding.hitTestPoint(theGame.player.x, theGame.player.y)) {
				if (upArrowDown == true) {
					var nextPage = new HatPage;
					removeChild(theGame.player);
					nextPage.setGame(theGame);
					theGame.player.x = 0;
					theGame.player.y = 450;
					theGame.addChild(nextPage);
					theGame.removeChild(this);
				}
			}

		}

	}
}