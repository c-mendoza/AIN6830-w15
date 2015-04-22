package {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import ain6830.Game;
	
	public class Main extends MovieClip {
		
		var startScreen:MovieClip;
		
		public function Main() {
			// constructor code
			startScreen = new StartScreen;
			startScreen.startButton.addEventListener(MouseEvent.CLICK, startClicked);
			addChild(startScreen);
		}
		
		function startClicked(e:MouseEvent) {
			removeChild(startScreen);
			addChild(new DemoGame);
		}
	}
	
}