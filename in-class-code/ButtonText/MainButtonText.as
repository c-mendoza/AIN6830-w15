package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class MainButtonText extends MovieClip {
		
		
		public function MainButtonText() {
			// constructor code
			redButton.addEventListener(MouseEvent.CLICK, redClicked);
		}
		
		public function redClicked(e) {
			myTextField.text += " HIIIIIIIIIIIII ";
			
		}
	}
	
}
