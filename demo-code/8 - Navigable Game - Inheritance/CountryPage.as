package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;


	public class CountryPage extends BasePage {


		public function CountryPage() {
			// constructor code
			super();

		}

		override function pageSetup() {
			theGame.player.scaleX = 0.4;
			theGame.player.scaleY = 0.4;
		}
		
		override function pageUpdate() {
			super.pageUpdate();

			//Check if we are at the edges

			if (theGame.player.x > stage.stageWidth) {
				theGame.player.x = stage.stageWidth;
			} else if (theGame.player.x < 0) {
				loadNextPage(new UptownPage, theGame.stage.stageWidth - 2, 300);
			}
		}

	}

}