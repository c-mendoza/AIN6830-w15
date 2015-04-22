package  ain6830 {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Platform extends MovieClip {

		public function Platform() {
			// constructor code
			
			addEventListener(Event.ADDED, addedToStage);
		}
		
		function addedToStage(e:Event) {
			(parent as PlatformLevel).addPlatform(this);
		}

	}
	
}
