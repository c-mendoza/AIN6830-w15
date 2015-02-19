package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class DowntownPage extends MovieClip {
		
		
		public function DowntownPage() {
			// constructor code
			utButton.addEventListener(MouseEvent.CLICK, goUptown);
		}
		
		function goUptown(e) {
			trace("in the class");
		}
	}
	
}
