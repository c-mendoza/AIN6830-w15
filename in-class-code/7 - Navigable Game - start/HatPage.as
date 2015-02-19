package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;


	public class HatPage extends MovieClip {

		var theGame: MainNavigableGame;
		var vx: Number;

		public function HatPage() {
			// constructor code

			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);

			vx = 0;

		}

		public function addedToStage(e: Event) {
			addEventListener(Event.ENTER_FRAME, myEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, myKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, myKeyUp);
		}

		public function removedFromStage(e: Event) {
			removeEventListener(Event.ENTER_FRAME, myEnterFrame);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, myKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, myKeyUp);
		}

		public function setGame(game: MainNavigableGame) {
			theGame = game;

			theGame.player.scaleX = theGame.player.scaleY = 0.7;

			addChild(theGame.player);

		}

		function myEnterFrame(e: Event) {
			theGame.player.x += vx;

			//Check if we are at the edges

			if (theGame.player.x > stage.stageWidth) {
				theGame.player.x = stage.stageWidth;
			} else if (theGame.player.x < 0) {
				var nextPage: MovieClip = new DowntownPage;
				removeChild(theGame.player);
				parent.removeChild(this);

				nextPage.setGame(theGame);
				theGame.addChild(nextPage);
				theGame.player.x = nextPage.hatBuilding.x + (nextPage.hatBuilding.width / 2);
				theGame.player.y = 300;
			}
		}

		function exitLeft() {
			trace("exit left");
			var nextPage: MovieClip = new DowntownPage;
			removeChild(theGame.player);
			parent.removeChild(this);

			nextPage.setGame(theGame);
			theGame.addChild(nextPage);
			theGame.player.x = nextPage.hatBuilding.x + (nextPage.hatBuilding.width / 2);
			theGame.player.y = 300;

		}


		function myKeyUp(e: KeyboardEvent) {

			if (e.keyCode == Keyboard.LEFT) {
				vx = 0;
			}

			if (e.keyCode == Keyboard.RIGHT) {
				vx = 0;
			}
		}

		function myKeyDown(e: KeyboardEvent) {

			if (e.keyCode == Keyboard.LEFT) {
				vx = -5;
			}

			if (e.keyCode == Keyboard.RIGHT) {
				vx = 5;
			}
		}
	}

}