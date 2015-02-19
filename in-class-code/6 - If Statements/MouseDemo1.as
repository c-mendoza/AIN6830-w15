package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class MouseDemo1 extends MovieClip {
		
		
		public function MouseDemo1() {
			// constructor code
			trace("Mouse Demo 1");
			
			addEventListener(Event.ENTER_FRAME, myEnterFrame);
			backButton.addEventListener(MouseEvent.CLICK, backClicked);
			
		} //End of constructor
		
		function myEnterFrame(e:Event) {
			
			if (stage.mouseX > stage.stageWidth /2) {
				myText.text = "On the right."
			} else if (stage.mouseX == stage.stageWidth/2) {
				myText.text = "Right on the center."
			} else {
				myText.text = "On the other right."

			}
		} //End of myEnterFrame
		
		
		function backClicked(e:MouseEvent) {
			trace("back clicked");
			
			removeEventListener(Event.ENTER_FRAME, myEnterFrame);
			parent.removeChild(this);
			
		}
	}
	
}
