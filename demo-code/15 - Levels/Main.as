package {

	import flash.display.MovieClip;

	public class Main extends MovieClip {



		public function Main() {
			// constructor code

			//You could add a loading screen here.
			//For now, I'm just instantiating the game:
			
			addChild(new DemoGame);

		}



	}

}