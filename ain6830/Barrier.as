package  ain6830 {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Barrier extends MovieClip {
		
		public function Barrier() {
			// constructor code
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		function addedToStage(e:Event) {
			(parent as TopDownLevel).addBarrier(this);
		}
		
	}
	
}
