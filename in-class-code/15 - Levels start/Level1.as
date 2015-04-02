package  {
	
	import flash.display.MovieClip;
	import ain6830.*;
	import flash.events.*;
	import flash.display.DisplayObject;
	
	public class Level1 extends PlatformLevel {
		
		
		public function Level1() {
			// constructor code
			trace("TESTING!");
			
			addTriggerArea(exit);
			exit.addEventListener(Level.TRIGGER_AREA_ENTERED, exitHit);
			
			addTriggerArea(t1Level1);
			t1Level1.addEventListener(Level.TRIGGER_AREA_ENTERED, t1Hit);
			xScrollMaxSpeed = 3;
			
			
		}
		
		public function t1Hit(e:Event) {
			trace("t1 hit!");

			removeTriggerArea(e.currentTarget as DisplayObject, false);
			t1Level1.removeEventListener(Level.TRIGGER_AREA_ENTERED, t1Hit);
		}
		
/*		public function t1Hit(e:Event) {
			trace("t1 hit!");
			removeTriggerArea(e.currentTarget as DisplayObject, true);
			t1Level1.removeEventListener(Level.TRIGGER_AREA_ENTERED, t1Hit);
		}*/
		
		public function exitHit(e:Event) {
			trace("exit hit!");
			loadNextLevel(new Level2, 100, 100);
		}
	}
	
}
