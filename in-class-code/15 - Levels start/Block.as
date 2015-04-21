package   {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Block extends MovieClip {
		
		
		public function Block() {
			// constructor code
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
			
		public function addedToStage(e:Event) {
			(parent as Main).addBlock(this);
		}
	}
	
}
