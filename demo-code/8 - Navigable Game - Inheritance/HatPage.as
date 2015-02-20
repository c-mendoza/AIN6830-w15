package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;


	public class HatPage extends BasePage {

		public function HatPage() {
			// constructor code
			trace("HatPage Constructor");

		}

		override function pageSetup() {
			theGame.player.scaleX = 0.7;
			theGame.player.scaleY = 0.7;
		}

		override function pageUpdate(){
			super.pageUpdate();

			//Check if we are at the edges:
			if (theGame.player.x > stage.stageWidth) {
				theGame.player.x = stage.stageWidth;
			} else if (theGame.player.x < 0) {
				var nextPage:DowntownPage = new DowntownPage;
				loadNextPage(nextPage, nextPage.hatBuilding.x + (nextPage.hatBuilding.width / 2), 300);
			}
		}

	}

}