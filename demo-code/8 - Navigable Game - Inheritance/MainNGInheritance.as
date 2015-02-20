package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;

	public class MainNGInheritance extends MovieClip {

		var player:Robot;
		
		
		public function MainNGInheritance() {
			// constructor code
			trace("MainNGInheritance Constructor");
			player = new Robot;
			
			var page:MovieClip = new UptownPage;
			
			page.setGame(this);
			
			addChild(page);
			player.x = 600;
			player.y = 300;
		}

	}

}