package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;

	public class BasePage extends MovieClip {

		//Variables that are common to anyone that should behave like a BasePage
		//go here: 
		var theGame: MainNGInheritance;
		var vx;

		public function BasePage() {
			// constructor code
			trace("BasePage Constructor");
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
			//Init numerical variables!
			vx = 0;
		}

		//EVENT FUNCTIONS ////////////////
		
		function addedToStage(e: Event) {
			addEventListener(Event.ENTER_FRAME, myEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, myKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, myKeyUp);
		}

		function removedFromStage(e: Event) {
			removeEventListener(Event.ENTER_FRAME, myEnterFrame);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, myKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, myKeyUp);
		}
		
		function myEnterFrame(e: Event) {
			pageUpdate();
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

		//Page-Related Functions ////////////////

		//Sets the game instance and triggers pageSetup()
		
		public function setGame(game: MainNGInheritance) {
			theGame = game;
			addChild(theGame.player);
			pageSetup();
		}

		//Function that gets called once, to do any kind of setup to the page before it
		//is displayed. Ex: Settting the scale of your player MovieClip.
		//You should override this function if you want to provide this
		//setup functionality.
		
		function pageSetup() {

		}

		//This function gets called on every frame. Override this and put in it any
		//code that needs to be run continuosly (like bounds checking, movement, etc).
		//Whatever you want ALL of the pageUpdate's to do you should put in here, and then
		//call super.pageUpdate() to execute it.
	
		function pageUpdate() {
			//This is what all pageUpdate's will have in common:
			theGame.player.x += vx;
			
			//But you can still override that if you want.
		}

		//This function loads the next page and sets the player's
		//position according the coordinates passed.
		//It will also remove this page as a child.
		
		function loadNextPage(nextPage:BasePage, playerX:Number, playerY:Number) {
			removeChild(theGame.player);
			parent.removeChild(this);

			nextPage.setGame(theGame);
			theGame.addChild(nextPage);
			theGame.player.x = playerX;
			theGame.player.y = playerY;
		}
		
	}
}