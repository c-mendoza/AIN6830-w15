package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class MainProjectiles extends MovieClip {
		
		
		public function MainProjectiles() {
			// constructor code
			
			var game = new SpaceInvadersGame;
			addChild(game);
		}
		
	}
	
}
