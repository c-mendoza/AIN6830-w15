package  {
	
	import flash.display.MovieClip;
	
	//Removes a MovieClip from the display list once
	//playback reaches the last frame.
	public class OneTimeMovie extends MovieClip {

		public function OneTimeMovie() {
			//The Undocumented “addFrameScript” Method
			//See: http://ryac.ca/the-undocumented-addframescript-method/?doing_wp_cron=1424830932.9560749530792236328125
			addFrameScript(totalFrames-1, onAnimationEnd);
		}
		
		private function onAnimationEnd() {
			//Check if we are still on the display list!
			if(parent) {
				parent.removeChild(this);
			}
		}

	}
	
}
