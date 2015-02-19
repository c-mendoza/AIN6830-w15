package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.AVSegmentedSource;
	
	public class MainInteractivePages extends MovieClip {
		
		var dtPage;
		var uptownPage;
		
		public function MainInteractivePages() {
			// constructor code
			trace("sanity for all");
			
			dtPage = new DowntownPage;
			
			addChild(dtPage);
			
			dtPage.building.addEventListener(MouseEvent.CLICK, test);
			
			dtPage.utButton.addEventListener(MouseEvent.CLICK, goUptown);
			
			trace(dtPage.utButton);
			
			uptownPage = new UptownPage;
			
			uptownPage.dtButton.addEventListener(MouseEvent.CLICK, goDowntown);
		}
		
		function goUptown(e) {
			trace(e.target);
			removeChild(dtPage);
			addChild(uptownPage);
		}
		
		function goDowntown(e) {
			trace("Going downtown");
		}
		
		function test(e) {
			trace(e.target);
		}
	}
	
}










