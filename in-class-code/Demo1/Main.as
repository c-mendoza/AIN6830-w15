package  {
	
	import flash.display.*;
	import flash.events.*;
	
	public class Main extends MovieClip {

		public function Main() {
			// constructor code
			trace("Hello! Is it me you are looking for?");
			trace(buttonOne); 
			
			buttonOne.addEventListener(MouseEvent.CLICK, buttonClicked);
			
			
		}
		
		public function buttonClicked(e) {
			trace("the button was clicked!!!!");
		}

	}
	
}
