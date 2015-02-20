package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;


	public class UptownPage extends BasePage {


		public function UptownPage() {
			// constructor code
			trace("UptownPage Constructor");
			//Nothing here...
		}


		override function pageSetup() {
			theGame.player.scaleX = 0.4;
			theGame.player.scaleY = 0.4;
		}
		
		override function pageUpdate() {
			super.pageUpdate();
			
			//Check if we are at the edges
			if (theGame.player.x > stage.stageWidth) {
				//exitRight();
				loadNextPage(new CountryPage, 0, 300);
			} else if (theGame.player.x < 0) {
				loadNextPage(new DowntownPage, theGame.stage.stageWidth, 300);
			}
		}
	}
}