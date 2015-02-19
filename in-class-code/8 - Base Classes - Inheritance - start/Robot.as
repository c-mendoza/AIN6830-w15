package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Robot extends MovieClip {
		
		var shakiness;
		var ox;
		var oy;
		
		public function Robot() {
			// constructor code
			
			
			//WANT TO INITIALIZE NUMERICAL VARS!
			shakiness = 10;
			ox = 0;
			oy = 0;
			
			addEventListener(Event.ADDED_TO_STAGE, myAdded);
		}
		
		function myAdded(e:Event) {
			ox = x;
			oy = y;
			addEventListener(Event.ENTER_FRAME, myEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, myRemoved);
			addEventListener(MouseEvent.CLICK, myClicked);
		}
		
		function myRemoved(e:Event) {
			removeEventListener(Event.ENTER_FRAME, myEnterFrame);
			removeEventListener(MouseEvent.CLICK, myClicked);
		}
		
		function myClicked(e:MouseEvent) {
			trace("robot clicked");
		}
		
		
		function myEnterFrame(e:Event) {
			trace("robot enter frame");
			
			this.x = ox + ((Math.random() * 2) - 1) * shakiness;
			this.y = oy + ((Math.random() * 2) - 1) * shakiness;
		}
	}
	
}







