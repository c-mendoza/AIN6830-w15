package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	public class MouseDemo2 extends MovieClip {
		
		
		public function MouseDemo2() {
			// constructor code
			trace("Mouse Demo 2 ENGAGED");
			backButton.addEventListener(MouseEvent.CLICK, backClicked);
			addEventListener(Event.ENTER_FRAME, myEnterFrame);
			
		}

		function myEnterFrame(e:Event) {
			
			var distance = calculateDistance(theTarget.x, theTarget.y, stage.mouseX, stage.mouseY);
			
			trace(distance);
		}
		
		function backClicked(e) {
			parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, myEnterFrame);
		}
		
		function calculateDistance(x1, y1, x2, y2) {
			var temp = Math.pow(x2-x1, 2) + Math.pow(y2-y1, 2);
			var distance = Math.sqrt(temp);
			return distance;
		}
		
		
		
		
	}
	
}









