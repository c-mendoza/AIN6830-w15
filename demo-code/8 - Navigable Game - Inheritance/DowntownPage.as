package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;


	public class DowntownPage extends BasePage {

		var upArrowDown: Boolean;

		public function DowntownPage() {
			// constructor code
			trace("DowntownPage Constructor");
			
			upArrowDown = false;
		}

		//If you want to change the behavior of a superclass function,
		//you need to declare it in the subclass with the keyword "override".
		
		override function pageSetup() {
			theGame.player.scaleX = 0.4;
			theGame.player.scaleY = 0.4;
		}

		//Override of pageUpdate
		//Notice that we want some of the behavior that pageUpdate had in the superclass,
		//so we call "super.pageUpdate()". What that does is call pageUpdate in the superclass, and
		//then we add our custom behavior.
		
		override function pageUpdate() {	
			//Calls the function in the superclass, which just moves the player at the moment.
			//If you don't call this, and you don't change the player's coordinates somewhere else in this function,
			//your player won't move!
			super.pageUpdate(); 

			//Check if we are at the edges
			if (theGame.player.x > stage.stageWidth) {
				trace("exit right");
				loadNextPage(new UptownPage, 0, 300);
			} else if (theGame.player.x < 0) {
				theGame.player.x = 0;
			}

			//Check if the arrow is down
			if (upArrowDown == true) {
				//If so, check if we are in contact with the hat building:
				if (hatBuilding.hitTestPoint(theGame.player.x, theGame.player.y)) {
					//If so, load the next page with our fancy loadNextPage function:
					loadNextPage(new HatPage, 0, 420);
					
					//Note that loadNextPage is defined in BasePage!
				}
			}
		}

		override function myKeyUp(e: KeyboardEvent) {
			//We DEFINITELY want the BasePage myKeyUp behavior...
			super.myKeyUp(e);

			//And then we add the special behavior that only DowntownPage needs:
			if (e.keyCode == Keyboard.UP) {
				upArrowDown = false;
			}
		}

		override function myKeyDown(e: KeyboardEvent) {
			super.myKeyDown(e);

			if (e.keyCode == Keyboard.UP) {
				upArrowDown = true;
			}
		}
	}

}