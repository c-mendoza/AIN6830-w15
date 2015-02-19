package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;

	public class MainNavigableGame extends MovieClip {

		var player:Robot;
		
		public function MainNavigableGame() {
			// constructor code
			trace("MainNavigableGame Constructor");
			
			var page = new DowntownPage;
			
			trace("The game in Main:", this);
			player = new Robot;
			
			page.setGame(this);
			
			addChild(page);
			
	
		}

	}

}