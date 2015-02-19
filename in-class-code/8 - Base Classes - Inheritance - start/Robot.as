package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Robot extends MovieClip {
		
		var shakiness;
		var ox;
		var oy;
		
		public function Robot() {
			// constructor code
			
			addEventListener(Event.ENTER_FRAME, myEnterFrame);
			
			//WANT TO INITIALIZE NUMERICAL VARS!
			shakiness = 10;
			
			addEventListener(Event.ADDED_TO_STAGE, myAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, myRemoved);
		}
		
		function myAdded(e:Event) {
			ox = x;
			oy = y;
		}
		
		function myRemoved(e:Event) {
			removeEventListener(Event.ENTER_FRAME, myEnterFrame);
		}
		
		function myEnterFrame(e:Event) {
			trace("robot enter frame");
			
			this.x = ox + ((Math.random() * 2) - 1) * shakiness;
			this.y = oy + ((Math.random() * 2) - 1) * shakiness;
		}
	}
	
}







