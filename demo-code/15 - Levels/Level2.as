package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import ain6830.Level;
	import ain6830.PlatformLevel;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	
	public class Level2 extends PlatformLevel {
		
		
		public function Level2() {
			// constructor code
			
			addTriggerArea(exitBack);
			exitBack.addEventListener(Level.TRIGGER_AREA_ENTERED, exitBackHandler);
			
			xScrollTarget = 0.4;
			yScrollTarget = 0.4;
			setScrolling(true, true, true, true);
			setScreenLimitsPlayerMovement(true, true, true, true);		
		}
		
		override public function setup() {
			
			game.createOption("Level2DoorOpen", false);
			
			if(game.getOption("Level2DoorOpen") == true) {
				door.y += door.height;
			} else {
				addTriggerArea(door);
				door.addEventListener(Level.TRIGGER_AREA_ENTERED, doorHitHandler);
			}
		}
		
		function exitBackHandler(e:Event) {
			game.loadNextLevel(new Level1, 1360, 1000);
		}

		function doorHitHandler(e:Event) {
			trace("here");
			if(game.getOption("HasLevel2DoorKey") == true) {
				new Tween(door, "y", Regular.easeOut, door.y, door.y + door.height, 1, true);
				game.setOption("Level2DoorOpen", true);
			}
		}
		
	}
	
}
