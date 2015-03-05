package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Bar extends MovieClip {
		
		var clock:Number = 0;
		var clockSpeed:Number = 0.01;
		var originY:Number;
		var amplitude:Number = 150;
		var phase:Number = 0;
		
		public function Bar() {
			// constructor code
			
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}
		
		function addedToStage(e:Event) {
			addEventListener(Event.ENTER_FRAME, enterFrame);
			originY = y;
		}
		
		function removedFromStage(e:Event) {
			removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		function enterFrame(e:Event) {
			clock = clock + clockSpeed;
			y = originY +  (Math.sin(clock + phase) * amplitude);
		}
	}
	
}
